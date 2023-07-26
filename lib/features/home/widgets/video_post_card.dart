import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/home/widgets/circle_animation.dart';
import 'package:drip_plus/features/home/widgets/comment_home_feed_bottom_sheet.dart';
import 'package:drip_plus/features/home/widgets/hastag_text.dart';
import 'package:drip_plus/features/home/widgets/home_video_player_item.dart';
import 'package:drip_plus/features/home/widgets/image_display_item.dart';
import 'package:drip_plus/features/home/widgets/show_products_feed_bottom_sheet.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:routemaster/routemaster.dart';

class VideoPostCard extends ConsumerStatefulWidget {
  final Post post;
  const VideoPostCard({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPostCardState();
}

class _VideoPostCardState extends ConsumerState<VideoPostCard> {
  bool isLikeAnimating = false;
  String? likeId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    isLikeAnimating = false;
  }

  void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

  void navigateToFeedValueDisplayScreen(BuildContext context, String postId) {
    Routemaster.of(context).push('/feed-value-display/$postId');
  }

  void followUser(WidgetRef ref, UserModel userModel) {
    ref.read(profileControllerProvider.notifier).followUser(userModel);
  }

  void likePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).likePost(widget.post);
  }

  void savePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).savePost(widget.post);
  }

  void bottomSheetHomeShowProducts(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ShowProductsFeedBottomSheet(post: widget.post);
        });
  }

  void bottomSheetHomeFeedComments(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CommentHomeFeedBottomSheet(post: widget.post);
        });
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTypeImage = widget.post.postType == 'image';
    final isTypeVideo = widget.post.postType == 'video';
    final isTypeCompare = widget.post.postType == 'compare';
    final pUser = ref.watch(userProvider)!;
    final userUid = pUser.uid;
    final isGuest = !pUser.isAuthenticated;
    return Stack(
      children: [
        isTypeVideo
            ? HomeVideoPlayerItem(post: widget.post)
            : ImageDisplayItem(post: widget.post),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child:
                            //Wing A
                            Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 20, bottom: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    // height: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: isTypeVideo
                                        ? const Icon(
                                            Icons.video_collection_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        : const Icon(
                                            CupertinoIcons
                                                .photo_fill_on_rectangle_fill,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => bottomSheetHomeShowProducts(
                                      context,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      // height: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.shopping_bag,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Check Products",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              ref
                                  .watch(getUserDataProvider(
                                      widget.post.publisherId))
                                  .when(
                                    data: (profileData) {
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                navigateToGeneralProfileScreen(
                                                    context, profileData.uid),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image(
                                                image: NetworkImage(
                                                  profileData.profilePic,
                                                ),
                                                fit: BoxFit.cover,
                                                height: 42,
                                                width: 42,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          GestureDetector(
                                            onTap: () =>
                                                navigateToGeneralProfileScreen(
                                                    context, profileData.uid),
                                            child: Text(
                                              profileData.username,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          pUser.uid == profileData.uid
                                              ? const SizedBox()
                                              : !pUser.following
                                                      .contains(profileData.uid)
                                                  ? GestureDetector(
                                                      onTap: () => followUser(
                                                          ref, profileData),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 16,
                                                                vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white24
                                                              .withOpacity(0.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white30),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "follow",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                        ],
                                      );
                                    },
                                    error: (error, stackTrace) => ErrorText(
                                      error: error.toString(),
                                    ),
                                    loading: () => const Loader(),
                                  ),
                              if (widget.post.description.isNotEmpty)
                                const SizedBox(height: 16),
                              if (widget.post.description.isNotEmpty)
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: ReadMoreText(
                                    widget.post.description,
                                    trimLines: 1,
                                    colorClickableText: Colors.pinkAccent,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'more',
                                    trimExpandedText: '...less',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                    moreStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                    ),
                                    lessStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              if (widget.post.description.isNotEmpty)
                                HashtagText(text: widget.post.description),
                              if (widget.post.sound.isNotEmpty ||
                                  widget.post.showLocation)
                                const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    if (widget.post.sound.isNotEmpty)
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.soundcloud,
                                              color: Pallete.whiteColor,
                                              size: 18,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Biggie Smalls",
                                              style: TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const Spacer(),
                                    if (widget.post.showLocation)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.location_on,
                                            color: Pallete.whiteColor,
                                          ),
                                          Text(
                                            "Lagos, ",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            "Nigeria",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Wing B
                      Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 12),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => navigateToFeedValueDisplayScreen(
                                      context, widget.post.postId),
                                  child: CircleAnimation(
                                    child: buildMusicAlbum(
                                      widget.post.thumbnail,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () => likePost(ref),
                                        icon: Icon(
                                          Icons.favorite,
                                          color: widget.post.likes
                                                  .contains(userUid)
                                              ? Colors.red
                                              : Colors.white,
                                          size: 36,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${widget.post.likes.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 18),
                                if (widget.post.allowComment)
                                  GestureDetector(
                                    onTap: () =>
                                        bottomSheetHomeFeedComments(context),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.chat_bubble,
                                            color: Colors.white,
                                            size: 36,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${widget.post.commentCount}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (widget.post.allowComment)
                                  const SizedBox(height: 18),
                                Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () => savePost(ref),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          color: widget.post.saves
                                                  .contains(userUid)
                                              ? Colors.amber
                                              : Colors.white,
                                          size: 36,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${widget.post.savesCount}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.share_sharp,
                                          color: Colors.white,
                                          size: 36,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${widget.post.sharesCount}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
