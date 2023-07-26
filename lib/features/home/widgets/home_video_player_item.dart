import 'package:drip_plus/features/home/controller/post_controller.dart';
import 'package:drip_plus/features/home/widgets/like_animation.dart';
import 'package:drip_plus/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeVideoPlayerItem extends ConsumerStatefulWidget {
  final Post post;
  const HomeVideoPlayerItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ConsumerState<HomeVideoPlayerItem> createState() =>
      _HomeVideoPlayerItemState();
}

class _HomeVideoPlayerItemState extends ConsumerState<HomeVideoPlayerItem> {
  CachedVideoPlayerController? _controller;
  bool isPlay = false;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    init();
    setState(() {
      isPlay = !isPlay;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void likePost(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).likePost(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: GestureDetector(
            onTap: () {
              if (isPlay) {
                _controller?.pause();
              } else {
                _controller?.play();
              }

              setState(() {
                isPlay = !isPlay;
              });
            },
            onDoubleTap: () {
              if (!widget.post.likes
                  .contains(FirebaseAuth.instance.currentUser!.uid)) {
                likePost(ref);
              }
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(children: [
              CachedVideoPlayer(_controller!),
              Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    !isPlay ? Icons.play_arrow : null,
                    size: 150,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
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
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> init() async {
    _controller = CachedVideoPlayerController.network(widget.post.videoUrl);
    _controller?.addListener(() {
      setState(() {});
    });
    await _controller?.initialize();
    _controller?.play();
    _controller?.setVolume(1);
    //_controller?.setLooping(true);
  }
}
