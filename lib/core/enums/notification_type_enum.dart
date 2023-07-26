enum NotificationType {
  like('like'),
  comment('comment'),
  follow('follow'),
  commentLike('commentLike');

  final String type;
  const NotificationType(this.type);
}

extension ConvertTweet on String {
  NotificationType toNotificationTypeEnum() {
    switch (this) {
      case 'commentLike':
        return NotificationType.commentLike;
      case 'follow':
        return NotificationType.follow;
      case 'comment':
        return NotificationType.comment;
      default:
        return NotificationType.like;
    }
  }
}
