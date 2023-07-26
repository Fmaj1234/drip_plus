import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/chat/controller/chat_controller.dart';
import 'package:drip_plus/features/chat/widgets/bottom_chat_field.dart';
import 'package:drip_plus/features/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class MobileChatScreen extends ConsumerWidget {
  final String uid;
  final bool isGroupChat;
  final String name;
  final String profilePic;
  const MobileChatScreen({
    super.key,
    required this.uid,
    required this.isGroupChat,
    required this.name,
    required this.profilePic,
  });

  void makeCall(
      WidgetRef ref, BuildContext context, String name, String profilePic) {
    ref.read(chatControllerProvider.notifier).makeCall(
          context,
          name,
          uid,
          profilePic,
          isGroupChat,
        );
  }

  void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

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
        titleSpacing: 0,
        title: isGroupChat
            ? ref.watch(getGroupDataProvider(uid)).when(
                  data: (profileData) {
                    return Text(
                      profileData.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    );
                  },
                 error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                )
            : ref.watch(getUserDataProvider(uid)).when(
                  data: (profileData) {
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: NetworkImage(
                              profileData.profilePic,
                            ),
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileData.username,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              profileData.isOnline ? 'online' : 'offline',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                ),
        centerTitle: false,
        actions: [
          ref.watch(getUserDataProvider(uid)).when(
                data: (profileData) {
                  return IconButton(
                    onPressed: () => makeCall(ref, context,
                        profileData.username, profileData.profilePic),
                    icon: const Icon(
                      Icons.video_call_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ref.watch(getUserDataProvider(uid)).when(
            //       data: (profileData) {
            //         return Expanded(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 const SizedBox(height: 12),
            //                 Container(
            //                   alignment: Alignment.center,
            //                   child: Column(
            //                     children: [
            //                       ClipRRect(
            //                         borderRadius: BorderRadius.circular(100),
            //                         child: Image(
            //                           image: NetworkImage(
            //                             profileData.profilePic,
            //                           ),
            //                           fit: BoxFit.cover,
            //                           height: 80,
            //                           width: 80,
            //                         ),
            //                       ),
            //                       const SizedBox(height: 8),
            //                       Text(
            //                         '@${profileData.username}',
            //                         style: const TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w500,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                       const SizedBox(height: 6),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             '${profileData.followers.length.toString()} followers -',
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               color: Colors.black54,
            //                             ),
            //                           ),
            //                           const SizedBox(width: 4),
            //                           Text(
            //                             "${profileData.totalLikesCount} likes",
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               color: Colors.black54,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       const SizedBox(height: 14),
            //                       Material(
            //                         color: tryingGreyMainColor,
            //                         borderRadius: BorderRadius.circular(10),
            //                         child: GestureDetector(
            //                           onTap: () =>
            //                               navigateToGeneralProfileScreen(
            //                                   context, profileData.uid),
            //                           child: Container(
            //                             height: 40,
            //                             width: 150,
            //                             padding: const EdgeInsets.symmetric(
            //                                 horizontal: 20, vertical: 12),
            //                             child: const Center(
            //                               child: Text(
            //                                 "View Profile",
            //                                 style: TextStyle(
            //                                   fontSize: 14,
            //                                   color: Colors.black,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       const SizedBox(height: 16),
            //                     ],
            //                   ),
            //                 ),
            //                 ChatList(
            //                   recieverUserId: uid,
            //                   isGroupChat: isGroupChat,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //       error: (error, stackTrace) => ErrorText(
            //         error: error.toString(),
            //       ),
            //       loading: () => const Loader(),
            //     ),
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      ),
    );
  }
}
