enum PostType {
  video('video'),
  image('image'),
  compare('compare');

  final String type;
  const PostType(this.type);
}

extension ConvertTweet on String {
  PostType toPostTypeEnum() {
    switch (this) {
      case 'video':
        return PostType.video;
      case 'image':
        return PostType.image;
      case 'compare':
        return PostType.compare;
      default:
        return PostType.video;
    }
  }
}
