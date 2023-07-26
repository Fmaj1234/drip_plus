import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileLikeWidget extends ConsumerWidget {
  final String profileuid;
  const ProfileLikeWidget({
    Key? key,
    required this.profileuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ref.watch(getUserLikesSavesProvider(profileuid)).when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GridView.builder(
                        itemCount: data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.63,
                        ),
                        itemBuilder: (context, index) {
                          var fetchPosts = data[index];
                          return Container(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  // city1. jpg
                                  image: NetworkImage(fetchPosts.thumbnail),
                                  fit: BoxFit.cover,
                                  opacity: 0.7,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  fetchPosts.postType == 'video'
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
                                  const Spacer(),
                                  fetchPosts.postType == 'video'
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.play_arrow_outlined,
                                              size: 24,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                            Text(
                                              '${fetchPosts.viewedPostCount}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
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
