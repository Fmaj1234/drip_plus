
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Call {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String receiverPic;
  final String callId;
  final bool hasDialled;
  Call({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.callId,
    required this.hasDialled,
  });

  Call copyWith({
    String? callerId,
    String? callerName,
    String? callerPic,
    String? receiverId,
    String? receiverName,
    String? receiverPic,
    String? callId,
    bool? hasDialled,
  }) {
    return Call(
      callerId: callerId ?? this.callerId,
      callerName: callerName ?? this.callerName,
      callerPic: callerPic ?? this.callerPic,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      receiverPic: receiverPic ?? this.receiverPic,
      callId: callId ?? this.callId,
      hasDialled: hasDialled ?? this.hasDialled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'callerId': callerId,
      'callerName': callerName,
      'callerPic': callerPic,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
      'callId': callId,
      'hasDialled': hasDialled,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      callerId: map['callerId'] ?? '',
      callerName: map['callerName'] ?? '',
      callerPic: map['callerPic'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      receiverPic: map['receiverPic'] ?? '',
      callId: map['callId'] ?? '',
      hasDialled: map['hasDialled'] ?? false,
    );
  }
  @override
  String toString() {
    return 'Call(callerId: $callerId, callerName: $callerName, callerPic: $callerPic, receiverId: $receiverId, receiverName: $receiverName, receiverPic: $receiverPic, callId: $callId, hasDialled: $hasDialled)';
  }

  @override
  bool operator ==(covariant Call other) {
    if (identical(this, other)) return true;
  
    return 
      other.callerId == callerId &&
      other.callerName == callerName &&
      other.callerPic == callerPic &&
      other.receiverId == receiverId &&
      other.receiverName == receiverName &&
      other.receiverPic == receiverPic &&
      other.callId == callId &&
      other.hasDialled == hasDialled;
  }

  @override
  int get hashCode {
    return callerId.hashCode ^
      callerName.hashCode ^
      callerPic.hashCode ^
      receiverId.hashCode ^
      receiverName.hashCode ^
      receiverPic.hashCode ^
      callId.hashCode ^
      hasDialled.hashCode;
  }
}
