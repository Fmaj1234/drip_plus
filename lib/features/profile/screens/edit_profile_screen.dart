import 'dart:io';

import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const EditProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? profileFile;
  Uint8List? profileWebFile;

  late TextEditingController usernameController;
  late TextEditingController bioController;
  final TextEditingController websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController =
        TextEditingController(text: ref.read(userProvider)!.username);
    bioController = TextEditingController(text: ref.read(userProvider)!.bio);
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    bioController.dispose();
    websiteController.dispose();
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          profileFile = File(res.files.first.path!);
        });
      }
    }
  }

  void save() {
    ref.read(profileControllerProvider.notifier).editProfile(
          profileFile: profileFile,
          context: context,
          name: usernameController.text.trim(),
          bio: bioController.text.trim(),
          website: websiteController.text.trim(),
          profileWebFile: profileWebFile,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
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
                "Edit Profile",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: save,
                    child: const Text('Save', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              profileWebFile != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(profileWebFile!),
                                      radius: 50,
                                    )
                                  : profileFile != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              FileImage(profileFile!),
                                          radius: 50,
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(user.profilePic),
                                          radius: 50,
                                        ),
                              Positioned(
                                bottom: -10,
                                left: 60,
                                child: IconButton(
                                  onPressed: selectProfileImage,
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f9fd),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff475269).withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person,
                                    size: 27, color: Color(0xff475269)),
                                const SizedBox(width: 15),
                                SizedBox(
                                  // margin: EdgeInsets..,
                                  width: 250,
                                  child: TextFormField(
                                    controller: usernameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your Username",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f9fd),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff475269).withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.book_online,
                                    size: 27, color: Color(0xff475269)),
                                const SizedBox(width: 15),
                                SizedBox(
                                  // margin: EdgeInsets..,
                                  width: 300,
                                  child: TextFormField(
                                    controller: bioController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your Bio",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xfff5f9fd),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff475269).withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.book_online,
                                    size: 27, color: Color(0xff475269)),
                                const SizedBox(width: 15),
                                SizedBox(
                                  // margin: EdgeInsets..,
                                  width: 250,
                                  child: TextFormField(
                                    controller: websiteController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your Website",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
