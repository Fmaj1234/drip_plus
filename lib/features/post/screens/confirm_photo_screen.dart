import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drip_plus/features/post/screens/preview_photo_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ConfirmPhotoScreen extends ConsumerStatefulWidget {
  final List<File> imageFiles;
  const ConfirmPhotoScreen({super.key, required this.imageFiles});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmPhotoScreenState();
}

class _ConfirmPhotoScreenState extends ConsumerState<ConfirmPhotoScreen> {
  int _current = 0;
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: widget.imageFiles.isNotEmpty
                  ? Stack(
                      children: [
                        CarouselSlider(
                          items: widget.imageFiles.map(
                            (file) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: Image.file(file, fit: BoxFit.cover),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                _count = index;
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
                              Text(
                                '#${_count + 1} Image',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    widget.imageFiles.asMap().entries.map((e) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
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
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.photo_fill_on_rectangle_fill,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Photo Preview",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 70,
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.video_collection_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.style,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Text",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.sticky_note_2,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Stickers",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.edit_off,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Effects",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.filter,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Filters",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.volume_mute_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Noise sounds",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.record_voice_over,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Audio",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 42,
                  ),
                  child: Material(
                    color: Colors.blue.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PreviewPhotoPostScreen(
                              images: widget.imageFiles,
                              firstImage: widget.imageFiles[0],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
