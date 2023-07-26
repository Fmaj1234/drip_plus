import 'dart:io';

import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/core/providers/storage_repository_provider.dart';
import 'package:drip_plus/features/post/controller/upload_controller.dart';
import 'package:drip_plus/features/post/widgets/post_product_item_display_widget.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class PreviewPostScreen extends ConsumerStatefulWidget {
  final File postVideoFile;
  final String postVideoPath;
  const PreviewPostScreen({
    super.key,
    required this.postVideoFile,
    required this.postVideoPath,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewPostScreenState();
}

class _PreviewPostScreenState extends ConsumerState<PreviewPostScreen> {
  File? tryItThumbNail;
  final _descriptionController = TextEditingController();
  // FocusManager.instance.primaryFocus?.unfocus();

  // SystemChannels.textInput.invokeMethod('TextInput.hide');

  bool _isSwitchedAllowComment = true;
  bool _isSwitchedAllowDuet = true;
  bool _isSwitchedAllowFeature = true;
  bool _isSwitchedAllowQualityUpload = false;
  bool _isSwitchedProductClick = true;
  bool _isSwitchedVendorDetails = true;
  bool _isSwitchedshowLocation = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void sendPost() async {
    ref.read(uploadControllerProvider.notifier).sendPost(
          context: context,
          description: _descriptionController.text.trim(),
          videoPath: widget.postVideoPath,
          images: [],
          repliedTo: '',
          repliedToUserId: '',
          isSwitchedAllowComment: _isSwitchedAllowComment,
          isSwitchedAllowDuet: _isSwitchedAllowDuet,
          isSwitchedAllowFeature: _isSwitchedAllowFeature,
          isSwitchedAllowQualityUpload: _isSwitchedAllowQualityUpload,
          isSwitchedProductClick: _isSwitchedProductClick,
          isSwitchedVendorDetails: _isSwitchedVendorDetails,
          isSwitchedshowLocation: _isSwitchedshowLocation,
        );
  }

  void navigateToCheckProductScreen(BuildContext context) {
    Routemaster.of(context).push('/check-product');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(uploadControllerProvider);
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
          "Post",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.more_vert,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                isLoading
                    ? const LinearProgressIndicator(color: Pallete.blueColor)
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(height: 1),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          height: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.7,
                                // width: 280,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          "Desribe your post. You can also add hastags and also flaunt your drips.",
                                      hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      hintMaxLines: 8,
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ),
                              if (tryItThumbNail != null)
                                SizedBox(
                                  height: 120.0,
                                  width: 90.0,
                                  child: AspectRatio(
                                    aspectRatio: 487 / 451,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.cover,
                                        alignment: FractionalOffset.topCenter,
                                        image: FileImage(tryItThumbNail!),
                                      )),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 0.8),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.person,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Tag people",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Pallete.greyColor,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.lock,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Who can watch this video",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "Everyone",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Pallete.greyColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.message,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow Comments",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedAllowComment,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedAllowComment = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.slideshow_outlined,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow Duets",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedAllowDuet,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedAllowDuet = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.switch_access_shortcut,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow Feature",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedAllowFeature,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedAllowFeature = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.video_collection,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow High Quality Videos",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedAllowQualityUpload,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedAllowQualityUpload = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.ads_click_outlined,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow Product Clickable",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedProductClick,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedProductClick = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Show Location",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedshowLocation,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedshowLocation = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Pallete.greyColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Allow Vendor Details",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isSwitchedVendorDetails,
                            onChanged: (value) {
                              setState(() {
                                _isSwitchedVendorDetails = value;
                              });
                            },
                            activeTrackColor:
                                Colors.blueAccent.withOpacity(0.4),
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.black12,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.grey, thickness: 0.8),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => navigateToCheckProductScreen(context),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
                              decoration: BoxDecoration(
                                color: Pallete.anotherGreyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_bag,
                                    color: Colors.black45,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: const Text(
                                      "Add Products",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      PostProductItemDisplayWidget(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundedStretchButton(
          onTap: sendPost,
          label: 'Post',
          isLoading: isLoading,
        ),
      ),
    );
  }

  Future<void> init() async {
    final postThumbnail = await ref
        .read(storageRepositoryProvider)
        .pickPostThumbNail(widget.postVideoFile);
    setState(() {
      tryItThumbNail = postThumbnail;
    });
  }
}
