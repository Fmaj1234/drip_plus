import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  final String type;
  final String notReceiver;
  final String userid;
  final String text;
  final String notificationId;
  final String postId;
  final String thumbNail;
  final DateTime datePublished;
  final bool isPost;
  final bool isRead;
  NotificationModel({
    required this.type,
    required this.notReceiver,
    required this.userid,
    required this.text,
    required this.notificationId,
    required this.postId,
    required this.thumbNail,
    required this.datePublished,
    required this.isPost,
    required this.isRead,
  });

  NotificationModel copyWith({
    String? type,
    String? notReceiver,
    String? userid,
    String? text,
    String? notificationId,
    String? postId,
    String? thumbNail,
    DateTime? datePublished,
    bool? isPost,
    bool? isRead,
  }) {
    return NotificationModel(
      type: type ?? this.type,
      notReceiver: notReceiver ?? this.notReceiver,
      userid: userid ?? this.userid,
      text: text ?? this.text,
      notificationId: notificationId ?? this.notificationId,
      postId: postId ?? this.postId,
      thumbNail: thumbNail ?? this.thumbNail,
      datePublished: datePublished ?? this.datePublished,
      isPost: isPost ?? this.isPost,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'notReceiver': notReceiver,
      'userid': userid,
      'text': text,
      'notificationId': notificationId,
      'postId': postId,
      'thumbNail': thumbNail,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'isPost': isPost,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      type: map['type'] ?? '',
      notReceiver: map['notReceiver'] ?? '',
      userid: map['userid'] ?? '',
      text: map['text'] ?? '',
      notificationId: map['notificationId'] ?? '',
      postId: map['postId'] ?? '',
      thumbNail: map['thumbNail'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      isPost: map['isPost'] ?? false,
      isRead: map['isRead'] ?? false,
    );
  }

  @override
  String toString() {
    return 'NotificationModel(type: $type, notReceiver: $notReceiver, userid: $userid, text: $text, notificationId: $notificationId, postId: $postId, thumbNail: $thumbNail, datePublished: $datePublished, isPost: $isPost, isRead: $isRead)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.notReceiver == notReceiver &&
        other.userid == userid &&
        other.text == text &&
        other.notificationId == notificationId &&
        other.postId == postId &&
        other.thumbNail == thumbNail &&
        other.datePublished == datePublished &&
        other.isPost == isPost &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        notReceiver.hashCode ^
        userid.hashCode ^
        text.hashCode ^
        notificationId.hashCode ^
        postId.hashCode ^
        thumbNail.hashCode ^
        datePublished.hashCode ^
        isPost.hashCode ^
        isRead.hashCode;
  }
}
