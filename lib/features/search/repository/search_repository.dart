import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider((ref) {
  return SearchRepository(firestore: ref.watch(firestoreProvider));
});

class SearchRepository {
  final FirebaseFirestore _firestore;
  SearchRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  Stream<List<Post>> productImagesSliderLists() {
    return _posts
        .orderBy('datePublished', descending: true)
        .limit(10)
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

  Stream<List<Post>> getSearchSliderLists() {
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

  Stream<List<Post>> getTopPostLists() {
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
}
