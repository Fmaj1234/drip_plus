import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/core/failure.dart';
import 'package:drip_plus/core/type_defs.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final uploadRepositoryProvider = Provider((ref) {
  return UploadRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class UploadRepository {
  final FirebaseFirestore _firestore;
  UploadRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  FutureVoid sendPost(Post post) async {
    try {
      return right(_posts.doc(post.postId).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
