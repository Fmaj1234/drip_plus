import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPlayerItemPost extends ConsumerStatefulWidget {
  final String videoUrl;
  const VideoPlayerItemPost({
    super.key,
    required this.videoUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoPlayerItemPostState();
}

class _VideoPlayerItemPostState extends ConsumerState<VideoPlayerItemPost> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }

  Future<void> init() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller?.addListener(() {
      setState(() {});
    });
    await _controller?.initialize();
    _controller?.play();
    _controller?.setVolume(1);
    _controller?.setLooping(true);
  }
}
