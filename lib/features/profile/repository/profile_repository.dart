import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/core/failure.dart';
import 'package:drip_plus/core/type_defs.dart';
import 'package:drip_plus/features/auth/screens/welcome_first_user_screen.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  ProfileRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  Stream<List<Post>> getUserPosts(String uid) {
    return _posts
        .where('publisherId', isEqualTo: uid)
        .orderBy('datePublished', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Post>> getUserFetchSaves(String profileuid) {
    return _posts
        .where('saves', arrayContains: profileuid)
        .orderBy('datePublished', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Post>> getUserLikesSaves(String uid) {
    return _posts
        .where('likes', arrayContains: uid)
        .orderBy('datePublished', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<UserModel>> getUserFollowers(String uid) {
    return _user
        .where('followers', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<UserModel> userModels = [];
      for (var doc in event.docs) {
        userModels.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return userModels;
    });
  }

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_user.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WelcomeFirstUserScreen(),
      ),
    );
    //Routemaster.of(context).push('/welcome-screen/');
    //Routemaster.of(context).push('_');
  }

  void followUser(UserModel profileUserModel, UserModel userModel,
      NotificationModel notificationData) async {
    if (userModel.following.contains(profileUserModel.uid)) {
      _user.doc(profileUserModel.uid).update({
        'followers': FieldValue.arrayRemove([userModel.uid])
      });
      _user.doc(userModel.uid).update({
        'following': FieldValue.arrayRemove([profileUserModel.uid])
      });
      _user.doc(profileUserModel.uid).update({
        'followersCount': FieldValue.increment(-1),
      });
      _user.doc(userModel.uid).update({
        'followingCount': FieldValue.increment(-1),
      });
      _user
          .doc(notificationData.notReceiver)
          .collection('notifications')
          .doc(notificationData.notificationId)
          .delete();
    } else {
      _user.doc(profileUserModel.uid).update({
        'followers': FieldValue.arrayUnion([userModel.uid])
      });
      _user.doc(userModel.uid).update({
        'following': FieldValue.arrayUnion([profileUserModel.uid])
      });
      _user.doc(profileUserModel.uid).update({
        'followersCount': FieldValue.increment(1),
      });
      _user.doc(userModel.uid).update({
        'followingCount': FieldValue.increment(1),
      });
      if (notificationData.notReceiver != userModel.uid) {
        _user
            .doc(notificationData.notReceiver)
            .collection('notifications')
            .doc(notificationData.notificationId)
            .set(notificationData.toMap());
      }
    }
  }

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);
}
