import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comments {
  final String profilePic;
  final String name;
  final String commenterId;
  final String postPublisherId;
  final String text;
  final String commentId;
  final String postId;
  final DateTime datePublished;
  final List<String> commentLikes;

  Comments({
    required this.profilePic,
    required this.name,
    required this.commenterId,
    required this.postPublisherId,
    required this.text,
    required this.commentId,
    required this.postId,
    required this.datePublished,
    required this.commentLikes,
  });

  Comments copyWith({
    String? profilePic,
    String? name,
    String? commenterId,
    String? postPublisherId,
    String? text,
    String? commentId,
    String? postId,
    DateTime? datePublished,
    List<String>? commentLikes,
  }) {
    return Comments(
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      commenterId: commenterId ?? this.commenterId,
      postPublisherId: postPublisherId ?? this.postPublisherId,
      text: text ?? this.text,
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      datePublished: datePublished ?? this.datePublished,
      commentLikes: commentLikes ?? this.commentLikes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePic': profilePic,
      'name': name,
      'commenterId': commenterId,
      'postPublisherId': postPublisherId,
      'text': text,
      'commentId': commentId,
      'postId': postId,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'commentLikes': commentLikes,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      profilePic: map['profilePic'] ?? '',
      name: map['name'] ?? '',
      commenterId: map['commenterId'] ?? '',
      postPublisherId: map['postPublisherId'] ?? '',
      text: map['text'] ?? '',
      commentId: map['commentId'] ?? '',
      postId: map['postId'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      commentLikes: List<String>.from(map['commentLikes']),
    );
  }

  @override
  String toString() {
    return 'Comments(profilePic: $profilePic, name: $name, commenterId: $commenterId, postPublisherId: $postPublisherId, text: $text, commentId: $commentId, postId: $postId, datePublished: $datePublished, commentLikes: $commentLikes)';
  }

  @override
  bool operator ==(covariant Comments other) {
    if (identical(this, other)) return true;

    return other.profilePic == profilePic &&
        other.name == name &&
        other.commenterId == commenterId &&
        other.postPublisherId == postPublisherId &&
        other.text == text &&
        other.commentId == commentId &&
        other.postId == postId &&
        other.datePublished == datePublished &&
        listEquals(other.commentLikes, commentLikes);
  }

  @override
  int get hashCode {
    return profilePic.hashCode ^
        name.hashCode ^
        commenterId.hashCode ^
        postPublisherId.hashCode ^
        text.hashCode ^
        commentId.hashCode ^
        postId.hashCode ^
        datePublished.hashCode ^
        commentLikes.hashCode;
  }
}
