import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedValueDisplayScreen extends ConsumerWidget {
  final String postId;
  const FeedValueDisplayScreen({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Style",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.bookmark_outline,
              size: 24,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.share,
              size: 24,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.more_vert,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ref.watch(getPostByIdProvider(postId)).when(
            data: (data) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 12, right: 12),
                              height: 130,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(
                                        data.thumbnail,
                                      ),
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Value Style",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 19, 15, 15),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          "Photography",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "450 posts",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, bottom: 4, left: 12, right: 12),
                              child: Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text(
                                        "Create Style",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child:
                                  Divider(color: Colors.grey, thickness: 0.8),
                            ),
                            const SizedBox(height: 4),
                            ref.watch(topPostListsProvider).when(
                                  data: (data) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GridView.builder(
                                        itemCount: data.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      fetchPosts.thumbnail),
                                                  fit: BoxFit.cover,
                                                  opacity: 0.7,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.play_arrow,
                                                        size: 28,
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                      ),
                                                      Text(
                                                        '${fetchPosts.viewedPostCount}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
