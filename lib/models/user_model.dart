import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String uid;
  final String profilePic;
  final String banner;
  final String username;
  final String lowerCaseUsername;
  final String bio;
  final List<String> followers;
  final List<String> following;
  final int followingCount;
  final int followersCount;
  final int totalLikesCount;
  final String password;
  final bool isOnline;
  final bool isAuthenticated;
  final bool privacy;
  final bool merchant;
  final bool isVerifiedBlue;
  final String phoneNumber;
  final String provider;
  final String status;
  final String website;
  final String interest;
  final String location;
  final DateTime timeAdded;
  final List<String> groupId;
  final int groupIdCount;
  const UserModel({
    required this.email,
    required this.uid,
    required this.profilePic,
    required this.banner,
    required this.username,
    required this.lowerCaseUsername,
    required this.bio,
    required this.followers,
    required this.following,
    required this.followingCount,
    required this.followersCount,
    required this.totalLikesCount,
    required this.password,
    required this.isOnline,
    required this.isAuthenticated,
    required this.privacy,
    required this.merchant,
    required this.isVerifiedBlue,
    required this.phoneNumber,
    required this.provider,
    required this.status,
    required this.website,
    required this.interest,
    required this.location,
    required this.timeAdded,
    required this.groupId,
    required this.groupIdCount,
  });

  UserModel copyWith({
    String? email,
    String? uid,
    String? profilePic,
    String? banner,
    String? username,
    String? lowerCaseUsername,
    String? bio,
    List<String>? followers,
    List<String>? following,
    int? followingCount,
    int? followersCount,
    int? totalLikesCount,
    String? password,
    bool? isOnline,
    bool? isAuthenticated,
    bool? privacy,
    bool? merchant,
    bool? isVerifiedBlue,
    String? phoneNumber,
    String? provider,
    String? status,
    String? website,
    String? interest,
    String? location,
    DateTime? timeAdded,
    List<String>? groupId,
    int? groupIdCount,
  }) {
    return UserModel(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      username: username ?? this.username,
      lowerCaseUsername: lowerCaseUsername ?? this.lowerCaseUsername,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      totalLikesCount: totalLikesCount ?? this.totalLikesCount,
      password: password ?? this.password,
      isOnline: isOnline ?? this.isOnline,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      privacy: privacy ?? this.privacy,
      merchant: merchant ?? this.merchant,
      isVerifiedBlue: isVerifiedBlue ?? this.isVerifiedBlue,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      website: website ?? this.website,
      interest: interest ?? this.interest,
      location: location ?? this.location,
      timeAdded: timeAdded ?? this.timeAdded,
      groupId: groupId ?? this.groupId,
      groupIdCount: groupIdCount ?? this.groupIdCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'profilePic': profilePic,
      'banner': banner,
      'username': username,
      'lowerCaseUsername': lowerCaseUsername,
      'bio': bio,
      'followers': followers,
      'following': following,
      'followingCount': followingCount,
      'followersCount': followersCount,
      'totalLikesCount': totalLikesCount,
      'password': password,
      'isOnline': isOnline,
      'isAuthenticated': isAuthenticated,
      'privacy': privacy,
      'merchant': merchant,
      'isVerifiedBlue': isVerifiedBlue,
      'phoneNumber': phoneNumber,
      'provider': provider,
      'status': status,
      'website': website,
      'interest': interest,
      'location': location,
      'timeAdded': timeAdded.millisecondsSinceEpoch,
      'groupId': groupId,
      'groupIdCount': groupIdCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      banner: map['banner'] ?? '',
      username: map['username'] ?? '',
      lowerCaseUsername: map['lowerCaseUsername'] ?? '',
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      followingCount: map['followingCount']?.toInt() ?? 0,
      followersCount: map['followersCount']?.toInt() ?? 0,
      totalLikesCount: map['totalLikesCount']?.toInt() ?? 0,
      password: map['password'] ?? '',
      isOnline: map['isOnline'] ?? false,
      isAuthenticated: map['isAuthenticated'] ?? false,
      privacy: map['privacy'] ?? false,
      merchant: map['merchant'] ?? false,
      isVerifiedBlue: map['isVerifiedBlue'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      provider: map['provider'] ?? '',
      status: map['status'] ?? '',
      website: map['website'] ?? '',
      interest: map['interest'] ?? '',
      location: map['location'] ?? '',
      timeAdded: DateTime.fromMillisecondsSinceEpoch(map['timeAdded']),
      groupId: List<String>.from(map['groupId']),
      groupIdCount: map['groupIdCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, uid: $uid, profilePic: $profilePic, banner: $banner, username: $username, bio: $bio, followers: $followers, following: $following, followingCount: $followingCount, followersCount: $followersCount, totalLikesCount: $totalLikesCount, password: $password, isOnline: $isOnline, isAuthenticated: $isAuthenticated, privacy: $privacy, merchant: $merchant, isVerifiedBlue: $isVerifiedBlue, phoneNumber: $phoneNumber, provider: $provider, status: $status, website: $website, interest: $interest, location: $location, timeAdded: $timeAdded, groupId: $groupId, groupIdCount: $groupIdCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.banner == banner &&
        other.username == username &&
        other.lowerCaseUsername == lowerCaseUsername &&
        other.bio == bio &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.followingCount == followingCount &&
        other.followersCount == followersCount &&
        other.totalLikesCount == totalLikesCount &&
        other.password == password &&
        other.isOnline == isOnline &&
        other.isAuthenticated == isAuthenticated &&
        other.privacy == privacy &&
        other.merchant == merchant &&
        other.isVerifiedBlue == isVerifiedBlue &&
        other.phoneNumber == phoneNumber &&
        other.provider == provider &&
        other.status == status &&
        other.website == website &&
        other.interest == interest &&
        other.location == location &&
        other.timeAdded == timeAdded &&
        listEquals(other.groupId, groupId) &&
        other.groupIdCount == groupIdCount;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        banner.hashCode ^
        username.hashCode ^
        lowerCaseUsername.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        followingCount.hashCode ^
        followersCount.hashCode ^
        totalLikesCount.hashCode ^
        password.hashCode ^
        isOnline.hashCode ^
        isAuthenticated.hashCode ^
        privacy.hashCode ^
        merchant.hashCode ^
        isVerifiedBlue.hashCode ^
        phoneNumber.hashCode ^
        provider.hashCode ^
        status.hashCode ^
        website.hashCode ^
        interest.hashCode ^
        location.hashCode ^
        timeAdded.hashCode ^
        groupId.hashCode ^
        groupIdCount.hashCode;
  }
}
