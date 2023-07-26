import 'dart:io';

import 'package:drip_plus/core/enums/post_type_enum.dart';
import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/post/repository/upload_repository.dart';
import 'package:drip_plus/home_screen.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final uploadControllerProvider =
    StateNotifierProvider<UploadController, bool>((ref) {
  final uploadRepository = ref.watch(uploadRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return UploadController(
    uploadRepository: uploadRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

class UploadController extends StateNotifier<bool> {
  final UploadRepository _uploadRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  UploadController({
    required UploadRepository uploadRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _uploadRepository = uploadRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void sendPost({
    required BuildContext context,
    required String description,
    required String videoPath,
    required List<File> images,
    required String repliedTo,
    required String repliedToUserId,
    required bool isSwitchedAllowComment,
    required bool isSwitchedAllowDuet,
    required bool isSwitchedAllowFeature,
    required bool isSwitchedAllowQualityUpload,
    required bool isSwitchedProductClick,
    required bool isSwitchedVendorDetails,
    required bool isSwitchedshowLocation,
  }) async {
    if (description.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        context: context,
        description: description,
        videoPath: videoPath,
        images: images,
        repliedTo: repliedTo,
        repliedToUserId: repliedToUserId,
        isSwitchedAllowComment: isSwitchedAllowComment,
        isSwitchedAllowDuet: isSwitchedAllowDuet,
        isSwitchedAllowFeature: isSwitchedAllowFeature,
        isSwitchedAllowQualityUpload: isSwitchedAllowQualityUpload,
        isSwitchedProductClick: isSwitchedProductClick,
        isSwitchedVendorDetails: isSwitchedVendorDetails,
        isSwitchedshowLocation: isSwitchedshowLocation,
      );
    } else {
      _shareVideoTweet(
        context: context,
        description: description,
        videoPath: videoPath,
        images: images,
        repliedTo: repliedTo,
        repliedToUserId: repliedToUserId,
        isSwitchedAllowComment: isSwitchedAllowComment,
        isSwitchedAllowDuet: isSwitchedAllowDuet,
        isSwitchedAllowFeature: isSwitchedAllowFeature,
        isSwitchedAllowQualityUpload: isSwitchedAllowQualityUpload,
        isSwitchedProductClick: isSwitchedProductClick,
        isSwitchedVendorDetails: isSwitchedVendorDetails,
        isSwitchedshowLocation: isSwitchedshowLocation,
      );
    }
  }

  void _shareImageTweet({
    required BuildContext context,
    required String description,
    required String videoPath,
    required List<File> images,
    required String repliedTo,
    required String repliedToUserId,
    required bool isSwitchedAllowComment,
    required bool isSwitchedAllowDuet,
    required bool isSwitchedAllowFeature,
    required bool isSwitchedAllowQualityUpload,
    required bool isSwitchedProductClick,
    required bool isSwitchedVendorDetails,
    required bool isSwitchedshowLocation,
  }) async {
    state = true;
    String postId = const Uuid().v1();

    final hashtags = _getHashtagsFromText(description);
    String link = _getLinkFromText(description);
    final user = _ref.read(userProvider)!;
    final imageRes = await _storageRepository.uploadImagesToStorage(
      path: 'posts/pictures',
      id: user.uid,
      files: images,
    );
    imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
      final Post post = Post(
        description: description,
        publisherId: user.uid,
        publisherName: user.username,
        postId: postId,
        link: link,
        retweetedBy: '',
        repliedTo: repliedTo,
        compareImage1: '',
        compareImage2: '',
        hashtags: hashtags,
        peopleTags: const [],
        commentIds: const [],
        imageLinks: r,
        reshare: const [],
        compareImage1Links: const [],
        compareImage2Links: const [],
        postTypeEnum: PostType.image,
        reshareCount: 0,
        likes: const [],
        shares: const [],
        saves: const [],
        values: const [],
        viewedPost: const [],
        commentCount: 0,
        likesCount: 0,
        sharesCount: 0,
        savesCount: 0,
        valuesCount: 0,
        viewedPostCount: 0,
        videoUrl: "",
        publisherProfImage: user.profilePic,
        datePublished: DateTime.now(),
        sound: "",
        thumbnail: r[0],
        postLocation: "",
        postType: "image",
        valueCategory: "",
        valueStrength: "",
        freeSlot1: "",
        freeSlot2: "",
        freeSlot3: "",
        userPrivacy: user.privacy,
        allowComment: isSwitchedAllowComment,
        allowDuet: isSwitchedAllowDuet,
        allowFeature: isSwitchedAllowFeature,
        allowQualityVideos: isSwitchedAllowQualityUpload,
        freeTrue1: true,
        freeTrue2: true,
        freeTrue3: true,
        freeTrue4: true,
        freeTrue5: true,
        freeSlot4: "",
        freeSlot5: "",
        privacyType: "",
        productClickable: isSwitchedProductClick,
        vendorDetails: isSwitchedVendorDetails,
        showLocation: isSwitchedshowLocation,
      );

      final res = await _uploadRepository.sendPost(post);
      state = false;
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Posted successfully!');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    });
  }

  void _shareVideoTweet({
    required BuildContext context,
    required String description,
    required String videoPath,
    required List<File> images,
    required String repliedTo,
    required String repliedToUserId,
    required bool isSwitchedAllowComment,
    required bool isSwitchedAllowDuet,
    required bool isSwitchedAllowFeature,
    required bool isSwitchedAllowQualityUpload,
    required bool isSwitchedProductClick,
    required bool isSwitchedVendorDetails,
    required bool isSwitchedshowLocation,
  }) async {
    state = true;
    String postId = const Uuid().v1();

    final hashtags = _getHashtagsFromText(description);
    String link = _getLinkFromText(description);
    final user = _ref.read(userProvider)!;
    String thumbnail = await _ref
        .read(storageRepositoryProvider)
        .uploadImageThumbnailToStorage(
          postId,
          videoPath,
        );
    final imageRes = await _storageRepository.uploadVideoToStorage(
      id: postId,
      videoPath: videoPath,
    );
    imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
      final Post post = Post(
        description: description,
        publisherId: user.uid,
        publisherName: user.username,
        postId: postId,
        link: link,
        retweetedBy: '',
        repliedTo: repliedTo,
        compareImage1: '',
        compareImage2: '',
        hashtags: hashtags,
        peopleTags: const [],
        commentIds: const [],
        imageLinks: const [],
        reshare: const [],
        compareImage1Links: const [],
        compareImage2Links: const [],
        postTypeEnum: PostType.video,
        reshareCount: 0,
        likes: const [],
        shares: const [],
        saves: const [],
        values: const [],
        viewedPost: const [],
        commentCount: 0,
        likesCount: 0,
        sharesCount: 0,
        savesCount: 0,
        valuesCount: 0,
        viewedPostCount: 0,
        videoUrl: r,
        publisherProfImage: user.profilePic,
        datePublished: DateTime.now(),
        sound: "",
        thumbnail: thumbnail,
        postLocation: "",
        postType: "video",
        valueCategory: "",
        valueStrength: "",
        freeSlot1: "",
        freeSlot2: "",
        freeSlot3: "",
        userPrivacy: user.privacy,
        allowComment: isSwitchedAllowComment,
        allowDuet: isSwitchedAllowDuet,
        allowFeature: isSwitchedAllowFeature,
        allowQualityVideos: isSwitchedAllowQualityUpload,
        freeTrue1: true,
        freeTrue2: true,
        freeTrue3: true,
        freeTrue4: true,
        freeTrue5: true,
        freeSlot4: "",
        freeSlot5: "",
        privacyType: "",
        productClickable: isSwitchedProductClick,
        vendorDetails: isSwitchedVendorDetails,
        showLocation: isSwitchedshowLocation,
      );

      final res = await _uploadRepository.sendPost(post);
      state = false;
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Posted successfully!');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    });
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
