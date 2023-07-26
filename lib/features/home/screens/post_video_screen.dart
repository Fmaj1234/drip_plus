import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/home/widgets/video_post_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class PostVideoScreen extends ConsumerWidget {
  final String postId;
  const PostVideoScreen({
    super.key,
    required this.postId,
  });

  void navigateToDiscoverScreen(BuildContext context) {
    Routemaster.of(context).push('/discover');
  }

  void navigateToShopScreen(BuildContext context) {
    Routemaster.of(context).push('/shopping');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          ref.watch(getPostByIdProvider(postId)).when(
                data: (data) {
                  return VideoPostCard(post: data);
                },
               error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => navigateToShopScreen(context),
                        child: Icon(
                          Icons.shopping_bag,
                          color: Colors.white.withOpacity(0.9),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 18),
                      GestureDetector(
                        onTap: () => navigateToDiscoverScreen(context),
                        child: Icon(
                          Icons.grid_view_rounded,
                          color: Colors.white.withOpacity(0.9),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
