// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class SubComment {
  final String commenterId;
  final String postPublisherId;
  final String text;
  final String commentId;
  final String postId;
  final DateTime datePublished;
  final List<String> commentLikes;
  final bool tagged;
  final String taggedUserId;
  final String subCommenterId;
  final String subText;
  final String subCommentId;
  final DateTime subDatePublished;
  final List<String> subCommentLikes;
  final int replyCount;
  SubComment({
    required this.commenterId,
    required this.postPublisherId,
    required this.text,
    required this.commentId,
    required this.postId,
    required this.datePublished,
    required this.commentLikes,
    required this.tagged,
    required this.taggedUserId,
    required this.subCommenterId,
    required this.subText,
    required this.subCommentId,
    required this.subDatePublished,
    required this.subCommentLikes,
    required this.replyCount,
  });

  SubComment copyWith({
    String? commenterId,
    String? postPublisherId,
    String? text,
    String? commentId,
    String? postId,
    DateTime? datePublished,
    List<String>? commentLikes,
    bool? tagged,
    String? taggedUserId,
    String? subCommenterId,
    String? subText,
    String? subCommentId,
    DateTime? subDatePublished,
    List<String>? subCommentLikes,
    int? replyCount,
  }) {
    return SubComment(
      commenterId: commenterId ?? this.commenterId,
      postPublisherId: postPublisherId ?? this.postPublisherId,
      text: text ?? this.text,
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      datePublished: datePublished ?? this.datePublished,
      commentLikes: commentLikes ?? this.commentLikes,
      tagged: tagged ?? this.tagged,
      taggedUserId: taggedUserId ?? this.taggedUserId,
      subCommenterId: subCommenterId ?? this.subCommenterId,
      subText: subText ?? this.subText,
      subCommentId: subCommentId ?? this.subCommentId,
      subDatePublished: subDatePublished ?? this.subDatePublished,
      subCommentLikes: subCommentLikes ?? this.subCommentLikes,
      replyCount: replyCount ?? this.replyCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commenterId': commenterId,
      'postPublisherId': postPublisherId,
      'text': text,
      'commentId': commentId,
      'postId': postId,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'commentLikes': commentLikes,
      'tagged': tagged,
      'taggedUserId': taggedUserId,
      'subCommenterId': subCommenterId,
      'subText': subText,
      'subCommentId': subCommentId,
      'subDatePublished': subDatePublished.millisecondsSinceEpoch,
      'subCommentLikes': subCommentLikes,
      'replyCount': replyCount,
    };
  }

  factory SubComment.fromMap(Map<String, dynamic> map) {
    return SubComment(
      commenterId: map['commenterId'] ?? '',
      postPublisherId: map['postPublisherId'] ?? '',
      text: map['text'] ?? '',
      commentId: map['commentId'] ?? '',
      postId: map['postId'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      commentLikes: List<String>.from(map['commentLikes']),
      tagged: map['tagged'] ?? false,
      taggedUserId: map['taggedUserId'] ?? '',
      subCommenterId: map['subCommenterId'] ?? '',
      subText: map['subText'] ?? '',
      subCommentId: map['subCommentId'] ?? '',
      subDatePublished: DateTime.fromMillisecondsSinceEpoch(map['subDatePublished']),
      subCommentLikes: List<String>.from(map['subCommentLikes']),
      replyCount: map['replyCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'SubComment(commenterId: $commenterId, postPublisherId: $postPublisherId, text: $text, commentId: $commentId, postId: $postId, datePublished: $datePublished, commentLikes: $commentLikes, tagged: $tagged, taggedUserId: $taggedUserId, subCommenterId: $subCommenterId, subText: $subText, subCommentId: $subCommentId, subDatePublished: $subDatePublished, subCommentLikes: $subCommentLikes, replyCount: $replyCount)';
  }

  @override
  bool operator ==(covariant SubComment other) {
    if (identical(this, other)) return true;
  
    return 
      other.commenterId == commenterId &&
      other.postPublisherId == postPublisherId &&
      other.text == text &&
      other.commentId == commentId &&
      other.postId == postId &&
      other.datePublished == datePublished &&
      listEquals(other.commentLikes, commentLikes) &&
      other.tagged == tagged &&
      other.taggedUserId == taggedUserId &&
      other.subCommenterId == subCommenterId &&
      other.subText == subText &&
      other.subCommentId == subCommentId &&
      other.subDatePublished == subDatePublished &&
      listEquals(other.subCommentLikes, subCommentLikes) &&
      other.replyCount == replyCount;
  }

  @override
  int get hashCode {
    return commenterId.hashCode ^
      postPublisherId.hashCode ^
      text.hashCode ^
      commentId.hashCode ^
      postId.hashCode ^
      datePublished.hashCode ^
      commentLikes.hashCode ^
      tagged.hashCode ^
      taggedUserId.hashCode ^
      subCommenterId.hashCode ^
      subText.hashCode ^
      subCommentId.hashCode ^
      subDatePublished.hashCode ^
      subCommentLikes.hashCode ^
      replyCount.hashCode;
  }
}
