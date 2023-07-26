import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/models/comments.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CommentHomeFeedBottomSheet extends ConsumerStatefulWidget {
  final Post post;
  const CommentHomeFeedBottomSheet({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommentHomeFeedBottomSheetState();
}

class _CommentHomeFeedBottomSheetState
    extends ConsumerState<CommentHomeFeedBottomSheet> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  var userData = {};
  FocusNode focusNode = FocusNode();

  void postComment(Post post) {
    ref.read(postControllerProvider.notifier).postComment(
          context,
          commentController.text.trim(),
          post,
        );
    setState(() {
      commentController.text = '';
    });
  }

  void commentLikePost(WidgetRef ref, Comments comments) async {
    ref
        .read(postControllerProvider.notifier)
        .commentLikePost(widget.post, comments);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final publisherUid = user.uid;
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Comments",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          const Divider(color: Colors.grey, thickness: 0.8),
          Expanded(
            child: ref.watch(commentListsProvider(widget.post.postId)).when(
                  data: (data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final commentData = data[index];
                        return Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  commentData.profilePic,
                                ),
                                backgroundColor: Colors.red,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 8),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          commentData.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          DateFormat.Hm().format(
                                              commentData.datePublished),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      commentData.text,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        commentLikePost(ref, commentData),
                                    child: commentData.commentLikes
                                            .contains(publisherUid)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 18,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.black45,
                                            size: 18,
                                          ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${commentData.commentLikes.length}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                 error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                ),
          ),
          const Divider(color: Colors.grey, thickness: 0.8),
          ref.watch(getUserDataProvider(widget.post.publisherId)).when(
                data: (user) => Container(
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xfff5f9fd,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: TextField(
                            focusNode: focusNode,
                            controller: commentController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Comment as ${user.username}',
                              border: InputBorder.none,
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => postComment(widget.post),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: const Text(
                            'Post',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
        ],
      ),
    );
  }
}
