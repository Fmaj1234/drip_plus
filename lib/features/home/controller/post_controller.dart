import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/home/repository/post_repository.dart';
import 'package:drip_plus/models/comments.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final getPostListsProvider = StreamProvider((ref) {
  return ref.watch(postControllerProvider.notifier).postLists();
});

final getPostGuestListsProvider = StreamProvider((ref) {
  return ref.watch(postControllerProvider.notifier).postGuestLists();
});

final getValueListsProvider = StreamProvider((ref) {
  return ref.watch(postControllerProvider.notifier).valueLists();
});

final commentListsProvider = StreamProvider.family((ref, String postId) {
  return ref.watch(postControllerProvider.notifier).commentLists(postId);
});

final getPostByIdProvider = StreamProvider.family((ref, String postId) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPostById(postId);
});

final userFollowersPostsProvider =
    StreamProvider.family((ref, List<UserModel> userModels) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchUserFollowersPosts(userModels);
});

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  Stream<List<Post>> postLists() {
    return _postRepository.getPostLists();
  }

  Stream<List<Post>> postGuestLists() {
    return _postRepository.getPostGuestLists();
  }

  Stream<List<Post>> valueLists() {
    return _postRepository.getValueLists();
  }

  Stream<List<Comments>> commentLists(String postId) {
    return _postRepository.commentLists(postId);
  }

  Stream<Post> getPostById(String postId) {
    return _postRepository.getPostById(postId);
  }

  Stream<List<Post>> fetchUserFollowersPosts(List<UserModel> userModels) {
    if (userModels.isNotEmpty) {
      return _postRepository.fetchUserFollowersPosts(userModels);
    }
    return Stream.value([]);
  }

  void likePost(Post post) async {
    String notificationId = const Uuid().v1();
    final uid = _ref.read(userProvider)!.uid;
    var timeSent = DateTime.now();
    NotificationModel notificationData = NotificationModel(
      type: "like",
      notReceiver: post.publisherId,
      userid: uid,
      text: "liked your post",
      notificationId: notificationId,
      postId: post.postId,
      thumbNail: post.thumbnail,
      datePublished: timeSent,
      isPost: true,
      isRead: false,
    );

    _postRepository.likePost(
      post,
      uid,
      notificationData,
    );
  }

  void savePost(Post post) async {
    final uid = _ref.read(userProvider)!.uid;
    _postRepository.savePost(
      post,
      uid,
    );
  }

  void commentLikePost(Post post, Comments comments) async {
    String notificationId = const Uuid().v1();
    final uid = _ref.read(userProvider)!.uid;
    var timeSent = DateTime.now();
    NotificationModel notificationData = NotificationModel(
      type: "like",
      notReceiver: post.publisherId,
      userid: uid,
      text: "liked your post",
      notificationId: notificationId,
      postId: post.postId,
      thumbNail: post.thumbnail,
      datePublished: timeSent,
      isPost: true,
      isRead: false,
    );
    _postRepository.commentLikePost(
      uid,
      notificationData,
      comments,
    );
  }

  void postComment(
    BuildContext context,
    String text,
    Post post,
  ) async {
    final user = _ref.read(userProvider)!;
    String notificationId = const Uuid().v1();
    NotificationModel notificationData = NotificationModel(
      type: "comment",
      notReceiver: post.publisherId,
      userid: user.uid,
      text: "commented on your post",
      notificationId: notificationId,
      postId: post.postId,
      thumbNail: post.thumbnail,
      datePublished: DateTime.now(),
      isPost: true,
      isRead: false,
    );
    String commentId = const Uuid().v1();
    Comments comment = Comments(
      commentId: commentId,
      text: text,
      datePublished: DateTime.now(),
      postId: post.postId,
      commenterId: user.uid,
      postPublisherId: post.publisherId,
      name: user.username,
      profilePic: user.profilePic,
      commentLikes: [],
    );
    _postRepository.postComment(comment, notificationData);
  }
}
