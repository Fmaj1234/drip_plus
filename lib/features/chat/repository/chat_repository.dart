import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/enums/message_enum.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/core/providers/message_reply_provider.dart';
import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/core/failure.dart';
import 'package:drip_plus/core/type_defs.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/models/call.dart';
import 'package:drip_plus/models/chat_contact.dart';
import 'package:drip_plus/models/group_model.dart';
import 'package:drip_plus/models/message.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class ChatRepository {
  final FirebaseFirestore _firestore;
  ChatRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);
  CollectionReference get _group =>
      _firestore.collection(FirebaseConstants.groupCollection);

  Stream<List<UserModel>> getSearchUsers(String typedUser) {
    return _users
        .where(
          'lowerCaseUsername',
          isGreaterThanOrEqualTo: typedUser.isEmpty ? 0 : typedUser,
          isLessThan: typedUser.isEmpty
              ? null
              : typedUser.substring(0, typedUser.length - 1) +
                  String.fromCharCode(
                    typedUser.codeUnitAt(typedUser.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<UserModel> userModels = [];
      for (var model in event.docs) {
        userModels.add(UserModel.fromMap(model.data() as Map<String, dynamic>));
      }
      return userModels;
    });
  }

  Stream<List<ChatContact>> getChatContacts() {
    //check chats firebase info for all the chat related to auth.uid
    return _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      //have a contact list as standby- the final list to be streamed into page
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        //loop through chats in firebase and load it ChatContact Model each
        var chatContact = ChatContact.fromMap(document.data());
        //load users data using infor from ChatContact model to determine present user info
        var userData = await _firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        //method used to determine the current info of user
        contacts.add(
          ChatContact(
            name: user.username,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  Stream<List<Message>> getGroupChatStream(String groudId) {
    return _firestore
        .collection('groups')
        .doc(groudId)
        .collection('chats')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  Stream<List<GroupModel>> getChatGroups() {
    return _firestore.collection('groups').snapshots().map((event) {
      List<GroupModel> groups = [];
      for (var document in event.docs) {
        var group = GroupModel.fromMap(document.data());
        if (group.membersUid.contains(FirebaseAuth.instance.currentUser!.uid)) {
          groups.add(group);
        }
      }
      return groups;
    });
  }

  Stream<GroupModel> getGroupData(String uid) {
    return _group.doc(uid).snapshots().map(
        (event) => GroupModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<List<UserModel>> getContacts() async {
    List<UserModel> contacts = [];
    try {
      var userCollection = await _firestore.collection('users').get();

      for (var document in userCollection.docs) {
        var groupDetails = UserModel.fromMap(document.data());
        contacts.add(groupDetails);
      }
      //contacts = await FlutterContacts.getContacts(withProperties: true);
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  FutureVoid createGroup(GroupModel group) async {
    try {
      return right(_group.doc(group.groupId).set(group.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
    bool isGroupChat,
  ) async {
    if (isGroupChat) {
      await _firestore.collection('groups').doc(recieverUserId).update({
        'lastMessage': text,
        'timeSent': DateTime.now().millisecondsSinceEpoch,
      });
    } else {
// users -> reciever user id => chats -> current user id -> set data
      var recieverChatContact = ChatContact(
        name: senderUserData.username,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await _firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            recieverChatContact.toMap(),
          );
      // users -> current user id  => chats -> reciever user id -> set data
      var senderChatContact = ChatContact(
        name: recieverUserData!.username,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .set(
            senderChatContact.toMap(),
          );
    }
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUsername,
    required String? recieverUserName,
    required bool isGroupChat,
  }) async {
    final message = Message(
      senderId: FirebaseAuth.instance.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : recieverUserName ?? '',
      repliedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
    );
    if (isGroupChat) {
      // groups -> group id -> chat -> message
      await _firestore
          .collection('groups')
          .doc(recieverUserId)
          .collection('chats')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    } else {
      // users -> sender id -> reciever id -> messages -> message id -> store message
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
      // users -> eciever id  -> sender id -> messages -> message id -> store message
      await _firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    }
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        var userDataMap =
            await _firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        text,
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.username,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.username,
        senderUsername: senderUser.username,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required Ref ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String imageUrl =
          await ref.read(storageRepositoryProvider).storeAnotherFileToFirebase(
                'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
                file,
              );

      UserModel? recieverUserData;
      if (!isGroupChat) {
        var userDataMap =
            await _firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataToContactsSubcollection(
        senderUserData,
        recieverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        //add real image-new
        text: imageUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.username,
        messageType: messageEnum,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.username,
        senderUsername: senderUserData.username,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      if (!isGroupChat) {
        var userDataMap =
            await _firestore.collection('users').doc(recieverUserId).get();
        recieverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
        senderUser,
        recieverUserData,
        'GIF',
        timeSent,
        recieverUserId,
        isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: gifUrl,
        timeSent: timeSent,
        messageType: MessageEnum.gif,
        messageId: messageId,
        username: senderUser.username,
        messageReply: messageReply,
        recieverUserName: recieverUserData?.username,
        senderUsername: senderUser.username,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await _firestore
          .collection('users')
          .doc(recieverUserId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Stream<DocumentSnapshot> get callStream => _firestore
      .collection('call')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  void makeCall(
    Call senderCallData,
    BuildContext context,
    Call receiverCallData,
  ) async {
    try {
      await _firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await _firestore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CallScreen(
      //       channelId: senderCallData.callId,
      //       call: senderCallData,
      //       isGroupChat: false,
      //     ),
      //   ),
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void makeGroupCall(
    Call senderCallData,
    BuildContext context,
    Call receiverCallData,
  ) async {
    try {
      await _firestore
          .collection('call')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await _firestore
          .collection('groups')
          .doc(senderCallData.receiverId)
          .get();
      GroupModel group = GroupModel.fromMap(groupSnapshot.data()!);

      for (var id in group.membersUid) {
        await _firestore
            .collection('call')
            .doc(id)
            .set(receiverCallData.toMap());
      }

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CallScreen(
      //       channelId: senderCallData.callId,
      //       call: senderCallData,
      //       isGroupChat: true,
      //     ),
      //   ),
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      await _firestore.collection('call').doc(callerId).delete();
      await _firestore.collection('call').doc(receiverId).delete();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void endGroupCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      await _firestore.collection('call').doc(callerId).delete();
      //load data from firebase group into groupsnapshot
      var groupSnapshot =
          await _firestore.collection('groups').doc(receiverId).get();
      //assigned loaded data from groupsnapshot in firebase into Group usermodel
      GroupModel group = GroupModel.fromMap(groupSnapshot.data()!);
      //loop through the firebase call data and select anyone whoever is the group and delete from call firebase
      for (var id in group.membersUid) {
        await _firestore.collection('call').doc(id).delete();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
