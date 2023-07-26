import 'package:carousel_slider/carousel_slider.dart';
import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/home/widgets/like_animation.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageDisplayItem extends ConsumerStatefulWidget {
  final Post post;
  const ImageDisplayItem({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImageDisplayItemState();
}

class _ImageDisplayItemState extends ConsumerState<ImageDisplayItem> {
  bool isPlay = false;
  bool isLikeAnimating = false;

  void likePost(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).likePost(widget.post);
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onDoubleTap: () {
              if (!widget.post.likes
                  .contains(FirebaseAuth.instance.currentUser!.uid)) {
                likePost(ref);
              }
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              children: [
                widget.post.imageLinks.isNotEmpty
                    ? Stack(
                        children: [
                          CarouselSlider(
                            items: widget.post.imageLinks.map(
                              (file) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  child: Image.network(file, fit: BoxFit.cover),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              height: MediaQuery.of(context).size.height,
                              enableInfiniteScroll: false,
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Column(
                              children: [
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.post.imageLinks
                                      .asMap()
                                      .entries
                                      .map((e) {
                                    return Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(
                                          _current == e.key ? 0.9 : 0.4,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 160,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
