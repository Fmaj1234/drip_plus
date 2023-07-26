import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/search/controller/search_controller.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTopPostsItemWidget extends ConsumerWidget {
  const SearchTopPostsItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Posts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Pallete.anotherGreyColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ref.watch(topPostListsProvider).when(
              data: (data) {
                return Padding(
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
                          height: 240,
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
                          child: ref
                              .watch(
                                  getUserDataProvider(fetchPosts.publisherId))
                              .when(
                                data: (user) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(1.5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image(
                                            image: NetworkImage(
                                              user.profilePic,
                                            ),
                                            fit: BoxFit.cover,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        user.username,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                               error: (error, stackTrace) => ErrorText(
                              error: error.toString(),
                            ),
                            loading: () => const Loader(),
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                              error: error.toString(),
                            ),
                            loading: () => const Loader(),
            ),
      ],
    );
  }
}
