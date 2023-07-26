import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupModel {
  final String senderId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final DateTime datePublished;
  final List<String> membersUid;
  GroupModel({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.datePublished,
    required this.membersUid,
  });

  GroupModel copyWith({
    String? senderId,
    String? name,
    String? groupId,
    String? lastMessage,
    String? groupPic,
    DateTime? datePublished,
    List<String>? membersUid,
  }) {
    return GroupModel(
      senderId: senderId ?? this.senderId,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      lastMessage: lastMessage ?? this.lastMessage,
      groupPic: groupPic ?? this.groupPic,
      datePublished: datePublished ?? this.datePublished,
      membersUid: membersUid ?? this.membersUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'name': name,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupPic': groupPic,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'membersUid': membersUid,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      senderId: map['senderId'] ?? '',
      name: map['name'] ?? '',
      groupId: map['groupId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      groupPic: map['groupPic'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      membersUid: List<String>.from(map['membersUid']),
    );
  }

  @override
  String toString() {
    return 'GroupModel(senderId: $senderId, name: $name, groupId: $groupId, lastMessage: $lastMessage, groupPic: $groupPic, datePublished: $datePublished, membersUid: $membersUid)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.senderId == senderId &&
      other.name == name &&
      other.groupId == groupId &&
      other.lastMessage == lastMessage &&
      other.groupPic == groupPic &&
      other.datePublished == datePublished &&
      listEquals(other.membersUid, membersUid);
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      lastMessage.hashCode ^
      groupPic.hashCode ^
      datePublished.hashCode ^
      membersUid.hashCode;
  }
}
