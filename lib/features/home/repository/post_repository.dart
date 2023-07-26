import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/models/comments.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(firestore: ref.watch(firestoreProvider));
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<List<Post>> getPostLists() {
    return _posts.orderBy('datePublished', descending: true).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Post>> getPostGuestLists() {
    return _posts.orderBy('datePublished', descending: true).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<Post> getPostById(String postId) {
    return _posts
        .doc(postId)
        .snapshots()
        .map((event) => Post.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<List<Post>> getValueLists() {
    return _posts.orderBy('datePublished', descending: true).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Comments>> commentLists(String postId) {
    return _posts
        .doc(postId)
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Comments.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Post>> fetchUserFollowersPosts(List<UserModel> userModels) {
    return _posts
        .where('publisherId', whereIn: userModels.map((e) => e.uid).toList())
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

  void likePost(
      Post post, String userId, NotificationModel notificationData) async {
    if (post.likes.contains(userId)) {
      _posts.doc(post.postId).update({
        'likes': FieldValue.arrayRemove([userId]),
      });
      _posts.doc(post.postId).update({
        'likesCount': FieldValue.increment(-1),
      });

      _users.doc(post.publisherId).update({
        'totalLikesCount': FieldValue.increment(-1),
      });
      _users
          .doc(notificationData.notReceiver)
          .collection('notifications')
          .doc(notificationData.notificationId)
          .delete();
    } else {
      _posts.doc(post.postId).update({
        'likes': FieldValue.arrayUnion([userId]),
      });

      _posts.doc(post.postId).update({
        'likesCount': FieldValue.increment(1),
      });

      _users.doc(post.publisherId).update({
        'totalLikesCount': FieldValue.increment(1),
      });
      if (notificationData.notReceiver != userId) {
        _users
            .doc(notificationData.notReceiver)
            .collection('notifications')
            .doc(notificationData.notificationId)
            .set(notificationData.toMap());
      }
    }
  }

  void savePost(Post post, String userId) async {
    if (post.saves.contains(userId)) {
      _posts.doc(post.postId).update({
        'saves': FieldValue.arrayRemove([userId]),
      });
      _posts.doc(post.postId).update({
        'savesCount': FieldValue.increment(-1),
      });
    } else {
      _posts.doc(post.postId).update({
        'saves': FieldValue.arrayUnion([userId]),
      });

      _posts.doc(post.postId).update({
        'savesCount': FieldValue.increment(1),
      });
    }
  }

  void commentLikePost(String userId, NotificationModel notificationData,
      Comments comments) async {
    if (comments.commentLikes.contains(userId)) {
      _posts
          .doc(comments.postId)
          .collection('comments')
          .doc(comments.commentId)
          .update({
        'commentLikes': FieldValue.arrayRemove([userId]),
      });

      _users
          .doc(notificationData.notReceiver)
          .collection('notifications')
          .doc(notificationData.notificationId)
          .delete();
    } else {
      _posts
          .doc(comments.postId)
          .collection('comments')
          .doc(comments.commentId)
          .update({
        'commentLikes': FieldValue.arrayUnion([userId]),
      });
      if (notificationData.notReceiver != userId) {
        _users
            .doc(notificationData.notReceiver)
            .collection('notifications')
            .doc(notificationData.notificationId)
            .set(notificationData.toMap());
      }
    }
  }

  void postComment(Comments comment, NotificationModel notificationData) async {
    _posts
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.commentId)
        .set(comment.toMap());
    if (notificationData.notReceiver != notificationData.userid) {
      _users
          .doc(notificationData.notReceiver)
          .collection('notifications')
          .doc(notificationData.notificationId)
          .set(notificationData.toMap());
    }

    _posts.doc(comment.postId).update({
      'commentCount': FieldValue.increment(1),
    });
  }
}
