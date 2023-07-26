import 'dart:io';
import 'dart:typed_data';

import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/profile/repository/profile_repository.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final userFollowersProvider = StreamProvider((ref) {
  final profileController = ref.watch(profileControllerProvider.notifier);
  return profileController.getUserFollowers();
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ProfileController(
    profileRepository: profileRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

final getUserPostsProvider = StreamProvider.family((ref, String uid) {
  return ref.read(profileControllerProvider.notifier).getUserPosts(uid);
});

final getUserFetchSavesProvider =
    StreamProvider.family((ref, String profileuid) {
  return ref
      .read(profileControllerProvider.notifier)
      .getUserFetchSaves(profileuid);
});

final getUserLikesSavesProvider =
    StreamProvider.family((ref, String profileuid) {
  return ref
      .read(profileControllerProvider.notifier)
      .getUserLikesSaves(profileuid);
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  ProfileController({
    required ProfileRepository profileRepository,
    required StorageRepository storageRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  Stream<List<Post>> getUserPosts(String uid) {
    return _profileRepository.getUserPosts(uid);
  }

  Stream<List<Post>> getUserFetchSaves(String profileuid) {
    return _profileRepository.getUserFetchSaves(profileuid);
  }

  Stream<List<Post>> getUserLikesSaves(String profileuid) {
    return _profileRepository.getUserLikesSaves(profileuid);
  }

  Stream<List<UserModel>> getUserFollowers() {
    final uid = _ref.read(userProvider)!.uid;
    return _profileRepository.getUserFollowers(uid);
  }

  void signOut(BuildContext context) async {
    await _profileRepository.signOut(context);
  }

  void editProfile({
    required File? profileFile,
    required Uint8List? profileWebFile,
    required BuildContext context,
    required String name,
    required String bio,
    required String website,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;

    if (profileFile != null || profileWebFile != null) {
      final res = await _storageRepository.storeFileToFirebase(
        path: 'users/profile',
        id: user.uid,
        file: profileFile,
        webFile: profileWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => user = user.copyWith(profilePic: r),
      );
    }

    user = user.copyWith(
        username: name,
        lowerCaseUsername: name.toLowerCase(),
        bio: bio,
        website: website);
    final res = await _profileRepository.editProfile(user);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        _ref.read(userProvider.notifier).update((state) => user);
        Routemaster.of(context).pop();
      },
    );
  }

  void followUser(UserModel profileUserModel) async {
    String notificationId = const Uuid().v1();
    final userModel = _ref.read(userProvider)!;
    var timeSent = DateTime.now();
    NotificationModel notificationData = NotificationModel(
      type: "follow",
      notReceiver: profileUserModel.uid,
      userid: userModel.uid,
      text: "followed you",
      notificationId: notificationId,
      postId: "",
      thumbNail: "",
      datePublished: timeSent,
      isPost: false,
      isRead: false,
    );

    _profileRepository.followUser(
        profileUserModel, userModel, notificationData);
  }
}
