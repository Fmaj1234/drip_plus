import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:drip_plus/core/enums/post_type_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first\
@immutable
class Post {
  final String publisherName;
  final String publisherId;
  final String postId;
  final String link;
  final String retweetedBy;
  final String repliedTo;
  final String compareImage1;
  final String compareImage2;
  final List<String> likes;
  final List<String> shares;
  final List<String> saves;
  final List<String> values;
  final List<String> viewedPost;
  final List<String> hashtags;
  final List<String> peopleTags;
  final List<String> imageLinks;
  final List<String> commentIds;
  final List<String> reshare;
  final List<String> compareImage1Links;
  final List<String> compareImage2Links;
  final PostType postTypeEnum;
  final int commentCount;
  final int likesCount;
  final int sharesCount;
  final int savesCount;
  final int valuesCount;
  final int viewedPostCount;
  final int reshareCount;
  final String sound;
  final DateTime datePublished;
  final String description;
  final String videoUrl;
  final String thumbnail;
  final String publisherProfImage;
  final String postLocation;
  final String postType;
  final String valueCategory;
  final String valueStrength;
  final bool userPrivacy;
  final bool allowComment;
  final bool allowDuet;
  final bool allowFeature;
  final bool allowQualityVideos;
  final bool freeTrue1;
  final bool freeTrue2;
  final bool freeTrue3;
  final bool freeTrue4;
  final bool freeTrue5;
  final String freeSlot1;
  final String freeSlot2;
  final String freeSlot3;
  final String freeSlot4;
  final String freeSlot5;
  final String privacyType;
  final bool productClickable;
  final bool vendorDetails;
  final bool showLocation;
  const Post({
    required this.publisherName,
    required this.publisherId,
    required this.postId,
    required this.link,
    required this.retweetedBy,
    required this.repliedTo,
    required this.compareImage1,
    required this.compareImage2,
    required this.likes,
    required this.shares,
    required this.saves,
    required this.values,
    required this.viewedPost,
    required this.hashtags,
    required this.peopleTags,
    required this.imageLinks,
    required this.commentIds,
    required this.reshare,
    required this.compareImage1Links,
    required this.compareImage2Links,
    required this.postTypeEnum,
    required this.commentCount,
    required this.likesCount,
    required this.sharesCount,
    required this.savesCount,
    required this.valuesCount,
    required this.viewedPostCount,
    required this.reshareCount,
    required this.sound,
    required this.datePublished,
    required this.description,
    required this.videoUrl,
    required this.thumbnail,
    required this.publisherProfImage,
    required this.postLocation,
    required this.postType,
    required this.valueCategory,
    required this.valueStrength,
    required this.userPrivacy,
    required this.allowComment,
    required this.allowDuet,
    required this.allowFeature,
    required this.allowQualityVideos,
    required this.freeTrue1,
    required this.freeTrue2,
    required this.freeTrue3,
    required this.freeTrue4,
    required this.freeTrue5,
    required this.freeSlot1,
    required this.freeSlot2,
    required this.freeSlot3,
    required this.freeSlot4,
    required this.freeSlot5,
    required this.privacyType,
    required this.productClickable,
    required this.vendorDetails,
    required this.showLocation,
  });

  Post copyWith({
    String? publisherName,
    String? publisherId,
    String? postId,
    String? link,
    String? retweetedBy,
    String? repliedTo,
    String? compareImage1,
    String? compareImage2,
    List<String>? likes,
    List<String>? shares,
    List<String>? saves,
    List<String>? values,
    List<String>? viewedPost,
    List<String>? hashtags,
    List<String>? peopleTags,
    List<String>? imageLinks,
    List<String>? commentIds,
    List<String>? reshare,
    List<String>? compareImage1Links,
    List<String>? compareImage2Links,
    PostType? postTypeEnum,
    int? commentCount,
    int? likesCount,
    int? sharesCount,
    int? savesCount,
    int? valuesCount,
    int? viewedPostCount,
    int? reshareCount,
    String? sound,
    DateTime? datePublished,
    String? description,
    String? videoUrl,
    String? thumbnail,
    String? publisherProfImage,
    String? postLocation,
    String? postType,
    String? valueCategory,
    String? valueStrength,
    bool? userPrivacy,
    bool? allowComment,
    bool? allowDuet,
    bool? allowFeature,
    bool? allowQualityVideos,
    bool? freeTrue1,
    bool? freeTrue2,
    bool? freeTrue3,
    bool? freeTrue4,
    bool? freeTrue5,
    String? freeSlot1,
    String? freeSlot2,
    String? freeSlot3,
    String? freeSlot4,
    String? freeSlot5,
    String? privacyType,
    bool? productClickable,
    bool? vendorDetails,
    bool? showLocation,
  }) {
    return Post(
      publisherName: publisherName ?? this.publisherName,
      publisherId: publisherId ?? this.publisherId,
      postId: postId ?? this.postId,
      link: link ?? this.link,
      retweetedBy: retweetedBy ?? this.retweetedBy,
      repliedTo: repliedTo ?? this.repliedTo,
      compareImage1: compareImage1 ?? this.compareImage1,
      compareImage2: compareImage2 ?? this.compareImage2,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
      saves: saves ?? this.saves,
      values: values ?? this.values,
      viewedPost: viewedPost ?? this.viewedPost,
      hashtags: hashtags ?? this.hashtags,
      peopleTags: peopleTags ?? this.peopleTags,
      imageLinks: imageLinks ?? this.imageLinks,
      commentIds: commentIds ?? this.commentIds,
      reshare: reshare ?? this.reshare,
      compareImage1Links: compareImage1Links ?? this.compareImage1Links,
      compareImage2Links: compareImage2Links ?? this.compareImage2Links,
      postTypeEnum: postTypeEnum ?? this.postTypeEnum,
      commentCount: commentCount ?? this.commentCount,
      likesCount: likesCount ?? this.likesCount,
      sharesCount: sharesCount ?? this.sharesCount,
      savesCount: savesCount ?? this.savesCount,
      valuesCount: valuesCount ?? this.valuesCount,
      viewedPostCount: viewedPostCount ?? this.viewedPostCount,
      reshareCount: reshareCount ?? this.reshareCount,
      sound: sound ?? this.sound,
      datePublished: datePublished ?? this.datePublished,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      publisherProfImage: publisherProfImage ?? this.publisherProfImage,
      postLocation: postLocation ?? this.postLocation,
      postType: postType ?? this.postType,
      valueCategory: valueCategory ?? this.valueCategory,
      valueStrength: valueStrength ?? this.valueStrength,
      userPrivacy: userPrivacy ?? this.userPrivacy,
      allowComment: allowComment ?? this.allowComment,
      allowDuet: allowDuet ?? this.allowDuet,
      allowFeature: allowFeature ?? this.allowFeature,
      allowQualityVideos: allowQualityVideos ?? this.allowQualityVideos,
      freeTrue1: freeTrue1 ?? this.freeTrue1,
      freeTrue2: freeTrue2 ?? this.freeTrue2,
      freeTrue3: freeTrue3 ?? this.freeTrue3,
      freeTrue4: freeTrue4 ?? this.freeTrue4,
      freeTrue5: freeTrue5 ?? this.freeTrue5,
      freeSlot1: freeSlot1 ?? this.freeSlot1,
      freeSlot2: freeSlot2 ?? this.freeSlot2,
      freeSlot3: freeSlot3 ?? this.freeSlot3,
      freeSlot4: freeSlot4 ?? this.freeSlot4,
      freeSlot5: freeSlot5 ?? this.freeSlot5,
      privacyType: privacyType ?? this.privacyType,
      productClickable: productClickable ?? this.productClickable,
      vendorDetails: vendorDetails ?? this.vendorDetails,
      showLocation: showLocation ?? this.showLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'publisherName': publisherName,
      'publisherId': publisherId,
      'postId': postId,
      'link': link,
      'retweetedBy': retweetedBy,
      'repliedTo': repliedTo,
      'compareImage1': compareImage1,
      'compareImage2': compareImage2,
      'likes': likes,
      'shares': shares,
      'saves': saves,
      'values': values,
      'viewedPost': viewedPost,
      'hashtags': hashtags,
      'peopleTags': peopleTags,
      'imageLinks': imageLinks,
      'commentIds': commentIds,
      'reshare': reshare,
      'compareImage1Links': compareImage1Links,
      'compareImage2Links': compareImage2Links,
      'postTypeEnum': postTypeEnum.type,
      'commentCount': commentCount,
      'likesCount': likesCount,
      'sharesCount': sharesCount,
      'savesCount': savesCount,
      'valuesCount': valuesCount,
      'viewedPostCount': viewedPostCount,
      'reshareCount': reshareCount,
      'sound': sound,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'publisherProfImage': publisherProfImage,
      'postLocation': postLocation,
      'postType': postType,
      'valueCategory': valueCategory,
      'valueStrength': valueStrength,
      'userPrivacy': userPrivacy,
      'allowComment': allowComment,
      'allowDuet': allowDuet,
      'allowFeature': allowFeature,
      'allowQualityVideos': allowQualityVideos,
      'freeTrue1': freeTrue1,
      'freeTrue2': freeTrue2,
      'freeTrue3': freeTrue3,
      'freeTrue4': freeTrue4,
      'freeTrue5': freeTrue5,
      'freeSlot1': freeSlot1,
      'freeSlot2': freeSlot2,
      'freeSlot3': freeSlot3,
      'freeSlot4': freeSlot4,
      'freeSlot5': freeSlot5,
      'privacyType': privacyType,
      'productClickable': productClickable,
      'vendorDetails': vendorDetails,
      'showLocation': showLocation,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      publisherName: map['publisherName'] ?? '',
      publisherId: map['publisherId'] ?? '',
      postId: map['postId'] ?? '',
      link: map['link'] ?? '',
      retweetedBy: map['retweetedBy'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      compareImage1: map['compareImage1'] ?? '',
      compareImage2: map['compareImage2'] ?? '',
      likes: List<String>.from(map['likes']),
      shares: List<String>.from(map['shares']),
      saves: List<String>.from(map['saves']),
      values: List<String>.from(map['values']),
      viewedPost: List<String>.from(map['viewedPost']),
      hashtags: List<String>.from(map['hashtags']),
      peopleTags: List<String>.from(map['peopleTags']),
      imageLinks: List<String>.from(map['imageLinks']),
      commentIds: List<String>.from(map['commentIds']),
      reshare: List<String>.from(map['reshare']),
      compareImage1Links: List<String>.from(map['compareImage1Links']),
      compareImage2Links: List<String>.from(map['compareImage2Links']),
      postTypeEnum: (map['postTypeEnum'] as String).toPostTypeEnum(),
      commentCount: map['commentCount']?.toInt() ?? 0,
      likesCount: map['likesCount']?.toInt() ?? 0,
      sharesCount: map['sharesCount']?.toInt() ?? 0,
      savesCount: map['savesCount']?.toInt() ?? 0,
      valuesCount: map['valuesCount']?.toInt() ?? 0,
      viewedPostCount: map['viewedPostCount']?.toInt() ?? 0,
      reshareCount: map['reshareCount']?.toInt() ?? 0,
      sound: map['sound'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      description: map['description'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      publisherProfImage: map['publisherProfImage'] ?? '',
      postLocation: map['postLocation'] ?? '',
      postType: map['postType'] ?? '',
      valueCategory: map['valueCategory'] ?? '',
      valueStrength: map['valueStrength'] ?? '',
      userPrivacy: map['userPrivacy'] ?? false,
      allowComment: map['allowComment'] ?? false,
      allowDuet: map['allowDuet'] ?? false,
      allowFeature: map['allowFeature'] ?? false,
      allowQualityVideos: map['allowQualityVideos'] ?? false,
      freeTrue1: map['freeTrue1'] ?? false,
      freeTrue2: map['freeTrue2'] ?? false,
      freeTrue3: map['freeTrue3'] ?? false,
      freeTrue4: map['freeTrue4'] ?? false,
      freeTrue5: map['freeTrue5'] ?? false,
      freeSlot1: map['freeSlot1'] ?? '',
      freeSlot2: map['freeSlot2'] ?? '',
      freeSlot3: map['freeSlot3'] ?? '',
      freeSlot4: map['freeSlot4'] ?? '',
      freeSlot5: map['freeSlot5'] ?? '',
      privacyType: map['privacyType'] ?? '',
      productClickable: map['productClickable'] ?? false,
      vendorDetails: map['vendorDetails'] ?? false,
      showLocation: map['showLocation'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Post(publisherName: $publisherName, publisherId: $publisherId, postId: $postId, link: $link, retweetedBy: $retweetedBy, repliedTo: $repliedTo, compareImage1: $compareImage1, compareImage2: $compareImage2, likes: $likes, shares: $shares, saves: $saves, values: $values, viewedPost: $viewedPost, hashtags: $hashtags, peopleTags: $peopleTags, imageLinks: $imageLinks, commentIds: $commentIds, reshare: $reshare, compareImage1Links: $compareImage1Links, compareImage2Links: $compareImage2Links, postTypeEnum: $postTypeEnum, commentCount: $commentCount, likesCount: $likesCount, sharesCount: $sharesCount, savesCount: $savesCount, valuesCount: $valuesCount, viewedPostCount: $viewedPostCount, reshareCount: $reshareCount, sound: $sound, datePublished: $datePublished, description: $description, videoUrl: $videoUrl, thumbnail: $thumbnail, publisherProfImage: $publisherProfImage, postLocation: $postLocation, postType: $postType, valueCategory: $valueCategory, valueStrength: $valueStrength, userPrivacy: $userPrivacy, allowComment: $allowComment, allowDuet: $allowDuet, allowFeature: $allowFeature, allowQualityVideos: $allowQualityVideos, freeTrue1: $freeTrue1, freeTrue2: $freeTrue2, freeTrue3: $freeTrue3, freeTrue4: $freeTrue4, freeTrue5: $freeTrue5, freeSlot1: $freeSlot1, freeSlot2: $freeSlot2, freeSlot3: $freeSlot3, freeSlot4: $freeSlot4, freeSlot5: $freeSlot5, privacyType: $privacyType, productClickable: $productClickable, vendorDetails: $vendorDetails, showLocation: $showLocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.publisherName == publisherName &&
        other.publisherId == publisherId &&
        other.postId == postId &&
        other.link == link &&
        other.retweetedBy == retweetedBy &&
        other.repliedTo == repliedTo &&
        other.compareImage1 == compareImage1 &&
        other.compareImage2 == compareImage2 &&
        listEquals(other.likes, likes) &&
        listEquals(other.shares, shares) &&
        listEquals(other.saves, saves) &&
        listEquals(other.values, values) &&
        listEquals(other.viewedPost, viewedPost) &&
        listEquals(other.hashtags, hashtags) &&
        listEquals(other.peopleTags, peopleTags) &&
        listEquals(other.imageLinks, imageLinks) &&
        listEquals(other.commentIds, commentIds) &&
        listEquals(other.reshare, reshare) &&
        listEquals(other.compareImage1Links, compareImage1Links) &&
        listEquals(other.compareImage2Links, compareImage2Links) &&
        other.postTypeEnum == postTypeEnum &&
        other.commentCount == commentCount &&
        other.likesCount == likesCount &&
        other.sharesCount == sharesCount &&
        other.savesCount == savesCount &&
        other.valuesCount == valuesCount &&
        other.viewedPostCount == viewedPostCount &&
        other.reshareCount == reshareCount &&
        other.sound == sound &&
        other.datePublished == datePublished &&
        other.description == description &&
        other.videoUrl == videoUrl &&
        other.thumbnail == thumbnail &&
        other.publisherProfImage == publisherProfImage &&
        other.postLocation == postLocation &&
        other.postType == postType &&
        other.valueCategory == valueCategory &&
        other.valueStrength == valueStrength &&
        other.userPrivacy == userPrivacy &&
        other.allowComment == allowComment &&
        other.allowDuet == allowDuet &&
        other.allowFeature == allowFeature &&
        other.allowQualityVideos == allowQualityVideos &&
        other.freeTrue1 == freeTrue1 &&
        other.freeTrue2 == freeTrue2 &&
        other.freeTrue3 == freeTrue3 &&
        other.freeTrue4 == freeTrue4 &&
        other.freeTrue5 == freeTrue5 &&
        other.freeSlot1 == freeSlot1 &&
        other.freeSlot2 == freeSlot2 &&
        other.freeSlot3 == freeSlot3 &&
        other.freeSlot4 == freeSlot4 &&
        other.freeSlot5 == freeSlot5 &&
        other.privacyType == privacyType &&
        other.productClickable == productClickable &&
        other.vendorDetails == vendorDetails &&
        other.showLocation == showLocation;
  }

  @override
  int get hashCode {
    return publisherName.hashCode ^
        publisherId.hashCode ^
        postId.hashCode ^
        link.hashCode ^
        retweetedBy.hashCode ^
        repliedTo.hashCode ^
        compareImage1.hashCode ^
        compareImage2.hashCode ^
        likes.hashCode ^
        shares.hashCode ^
        saves.hashCode ^
        values.hashCode ^
        viewedPost.hashCode ^
        hashtags.hashCode ^
        peopleTags.hashCode ^
        imageLinks.hashCode ^
        commentIds.hashCode ^
        reshare.hashCode ^
        compareImage1Links.hashCode ^
        compareImage2Links.hashCode ^
        postTypeEnum.hashCode ^
        commentCount.hashCode ^
        likesCount.hashCode ^
        sharesCount.hashCode ^
        savesCount.hashCode ^
        valuesCount.hashCode ^
        viewedPostCount.hashCode ^
        reshareCount.hashCode ^
        sound.hashCode ^
        datePublished.hashCode ^
        description.hashCode ^
        videoUrl.hashCode ^
        thumbnail.hashCode ^
        publisherProfImage.hashCode ^
        postLocation.hashCode ^
        postType.hashCode ^
        valueCategory.hashCode ^
        valueStrength.hashCode ^
        userPrivacy.hashCode ^
        allowComment.hashCode ^
        allowDuet.hashCode ^
        allowFeature.hashCode ^
        allowQualityVideos.hashCode ^
        freeTrue1.hashCode ^
        freeTrue2.hashCode ^
        freeTrue3.hashCode ^
        freeTrue4.hashCode ^
        freeTrue5.hashCode ^
        freeSlot1.hashCode ^
        freeSlot2.hashCode ^
        freeSlot3.hashCode ^
        freeSlot4.hashCode ^
        freeSlot5.hashCode ^
        privacyType.hashCode ^
        productClickable.hashCode ^
        vendorDetails.hashCode ^
        showLocation.hashCode;
  }
}
