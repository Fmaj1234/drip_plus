import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/home/widgets/video_post_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class FeedVideoScreen extends ConsumerWidget {
  const FeedVideoScreen({super.key});

  void navigateToDiscoverScreen(BuildContext context) {
    Routemaster.of(context).push('/discover');
  }

  void navigateToShopScreen(BuildContext context) {
    Routemaster.of(context).push('/shopping');
  }

  void navigateToFollowersScreen(BuildContext context) {
    Routemaster.of(context).push('/followers');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          isGuest
              ? ref.watch(getPostListsProvider).when(
                    data: (data) {
                      return PageView.builder(
                        itemCount: data.length,
                        controller:
                            PageController(initialPage: 0, viewportFraction: 1),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final post = data[index];
                          return VideoPostCard(post: post);
                        },
                      );
                    },
                    error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                  )
              : ref.watch(getPostGuestListsProvider).when(
                    data: (data) {
                      return PageView.builder(
                        itemCount: data.length,
                        controller:
                            PageController(initialPage: 0, viewportFraction: 1),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final post = data[index];
                          return VideoPostCard(post: post);
                        },
                      );
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
                  const Text(
                    "Drips Vibes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
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
                      const SizedBox(width: 18),
                      GestureDetector(
                        onTap: () => navigateToFollowersScreen(context),
                        child: Icon(
                          Icons.groups_sharp,
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
