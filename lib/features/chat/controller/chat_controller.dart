import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/core/enums/message_enum.dart';
import 'package:drip_plus/core/providers/message_reply_provider.dart';
import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/chat/repository/chat_repository.dart';
import 'package:drip_plus/models/call.dart';
import 'package:drip_plus/models/chat_contact.dart';
import 'package:drip_plus/models/group_model.dart';
import 'package:drip_plus/models/message.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final getContactsProvider = FutureProvider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return chatRepository.getContacts();
});

final chatControllerProvider =
    StateNotifierProvider<ChatController, bool>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final searchChatUsersProvider = StreamProvider.family((ref, String typedUser) {
  return ref.watch(chatControllerProvider.notifier).searchUsers(typedUser);
});

final getChatContactsProvider = StreamProvider((ref) {
  return ref.watch(chatControllerProvider.notifier).chatContacts();
});

final getChatGroupsProvider = StreamProvider((ref) {
  return ref.watch(chatControllerProvider.notifier).chatGroups();
});

final getChatStreamProvider =
    StreamProvider.family((ref, String recieverUserId) {
  return ref.watch(chatControllerProvider.notifier).chatStream(recieverUserId);
});

final getGroupChatStreamProvider = StreamProvider.family((ref, String groupId) {
  return ref.watch(chatControllerProvider.notifier).groupChatStream(groupId);
});

final getGroupDataProvider = StreamProvider.family((ref, String uid) {
  final chatController = ref.watch(chatControllerProvider.notifier);
  return chatController.getGroupData(uid);
});

class ChatController extends StateNotifier<bool> {
  final ChatRepository _chatRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  ChatController({
    required ChatRepository chatRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _chatRepository = chatRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  Stream<List<UserModel>> searchUsers(String typedUser) {
    return _chatRepository.getSearchUsers(typedUser);
  }

  Stream<List<ChatContact>> chatContacts() {
    return _chatRepository.getChatContacts();
  }

  Stream<List<GroupModel>> chatGroups() {
    return _chatRepository.getChatGroups();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return _chatRepository.getChatStream(recieverUserId);
  }

  Stream<List<Message>> groupChatStream(String groupId) {
    return _chatRepository.getGroupChatStream(groupId);
  }

   Stream<GroupModel> getGroupData(String uid) {
    return _chatRepository.getGroupData(uid);
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    _chatRepository.setChatMessageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }

  void createGroup(BuildContext context, String name, File? profilePic,
      Uint8List? profileWebFile, List<UserModel> selectedContact) async {
    state = true;
    List<String> uids = [];
    for (int i = 0; i < selectedContact.length; i++) {
      var userCollection =
          await FirebaseFirestore.instance.collection('users').get();

      if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
        uids.add(userCollection.docs[0].data()['uid']);
      }
    }
    var groupId = const Uuid().v1();
    final uid = _ref.read(userProvider)?.uid ?? '';

    final imageRes = await _storageRepository.storeFileToFirebase(
      path: 'chatGroup/profile',
      id: name,
      file: profilePic,
      webFile: profileWebFile,
    );

    imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
      final GroupModel group = GroupModel(
        senderId: uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        //add real image-new
        groupPic: r,
        membersUid: [uid, ...uids],
        datePublished: DateTime.now(),
      );

      final res = await _chatRepository.createGroup(group);
      state = false;
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Group created successfully!');
        Routemaster.of(context).pop();
      });
    });
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReply = _ref.read(messageReplyProvider);
    final user = _ref.read(userProvider)!;
    _ref.read(getUserDataProvider(user.uid)).whenData(
          (value) => _chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          ),
        );
    _ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
    
  ) {
    final messageReply = _ref.read(messageReplyProvider);
    final user = _ref.read(userProvider)!;
    _ref.read(getUserDataProvider(user.uid)).whenData(
          (value) => _chatRepository.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: value,
            messageEnum: messageEnum,
            ref: _ref,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
            
          ),
        );
    _ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReply = _ref.read(messageReplyProvider);
    final user = _ref.read(userProvider)!;
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    _ref.read(getUserDataProvider(user.uid)).whenData(
          (value) => _chatRepository.sendGIFMessage(
            context: context,
            gifUrl: newgifUrl,
            recieverUserId: recieverUserId,
            senderUser: value,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          ),
        );
    _ref.read(messageReplyProvider.state).update((state) => null);
  }

  Stream<DocumentSnapshot> get callStream => _chatRepository.callStream;

  void makeCall(BuildContext context, String receiverName, String receiverUid,
      String receiverProfilePic, bool isGroupChat) {
        final user = _ref.read(userProvider)!;
    _ref.read(getUserDataProvider(user.uid)).whenData((value) {
      String callId = const Uuid().v1();
      Call senderCallData = Call(
        callerId: FirebaseAuth.instance.currentUser!.uid,
        callerName: value.username,
        callerPic: value.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      Call recieverCallData = Call(
        callerId: FirebaseAuth.instance.currentUser!.uid,
        callerName: value.username,
        callerPic: value.profilePic,
        receiverId: receiverUid,
        receiverName: receiverName,
        receiverPic: receiverProfilePic,
        callId: callId,
        hasDialled: false,
      );
      if (isGroupChat) {
        _chatRepository.makeGroupCall(
            senderCallData, context, recieverCallData);
      } else {
        _chatRepository.makeCall(senderCallData, context, recieverCallData);
      }
    });
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) {
    _chatRepository.endCall(callerId, receiverId, context);
  }
}
