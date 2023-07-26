import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRepositoryProvider = Provider((ref) {
  return NotificationRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class NotificationRepository {
  final FirebaseFirestore _firestore;
  NotificationRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<List<NotificationModel>> notificationLists(String userId) {
    return _users
        .doc(userId)
        .collection('notifications')
        .orderBy('datePublished', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => NotificationModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  void updateNotification(NotificationModel notification) async {
    _users
        .doc(notification.notReceiver)
        .collection('notifications')
        .doc(notification.notificationId)
        .update({'isRead': true});
  }
}
