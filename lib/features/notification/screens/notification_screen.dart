import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/auth/screens/welcome_screen.dart';
import 'package:drip_plus/features/notification/controller/notification_controller.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/models/notification_model.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

  void navigateToPostVideo(BuildContext context, String postId,
      NotificationModel notification, WidgetRef ref) {
    Routemaster.of(context).push('/post-video/$postId');
    ref
        .read(notificationControllerProvider.notifier)
        .updateNotification(notification);
  }

  void navigateToGeneralProfileScreenAndUnreadNotification(BuildContext context,
      String uid, NotificationModel notification, WidgetRef ref) {
    Routemaster.of(context).push('/general-profile/$uid');
    ref
        .read(notificationControllerProvider.notifier)
        .updateNotification(notification);
  }

  void navigateToChatScreen(BuildContext context) {
    Routemaster.of(context).push('/chat');
  }

  void followUser(WidgetRef ref, UserModel userModel) {
    ref.read(profileControllerProvider.notifier).followUser(userModel);
  }

  void navigateToWelcomeScreen(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const WelcomeScreen();
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final userId = user.uid;
    if (isGuest) {
      return Center(
        child: GestureDetector(
          onTap: () => navigateToWelcomeScreen(context),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Notification",
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
              child: Row(
                children: [
                  InkWell(
                    onTap: () => navigateToChatScreen(context),

                    //add Badge to child below
                    child: Icon(
                      Icons.chat_bubble_rounded,
                      size: 24,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: ref.watch(notificationListsProvider).when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var notificationData = data[index];

                      if (!notificationData.isPost) {
                        return GestureDetector(
                          onTap: () =>
                              navigateToGeneralProfileScreenAndUnreadNotification(
                                  context,
                                  notificationData.userid,
                                  notificationData,
                                  ref),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              color: notificationData.isRead
                                  ? Colors.blue.withOpacity(0.0)
                                  : Colors.blue.withOpacity(0.1),
                            ),
                            child: ref
                                .watch(getUserDataProvider(
                                    notificationData.userid))
                                .when(
                                  data: (user) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              navigateToGeneralProfileScreen(
                                                  context, user.uid),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image(
                                              image: NetworkImage(
                                                user.profilePic,
                                              ),
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          navigateToGeneralProfileScreen(
                                                              context,
                                                              user.uid),
                                                      child: Text(
                                                        user.username,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      notificationData.text,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  DateFormat.Hm().format(
                                                      notificationData
                                                          .datePublished),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        userId == user.uid
                                            ? const SizedBox()
                                            : Material(
                                                color: user.followers
                                                        .contains(userId)
                                                    ? Pallete.anotherGreyColor
                                                    : Pallete.blueColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: InkWell(
                                                  onTap: () =>
                                                      followUser(ref, user),
                                                  child: Container(
                                                    height: 40,
                                                    width: 120,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
                                                    child: Center(
                                                      child: Text(
                                                        user.followers.contains(
                                                                userId)
                                                            ? 'unfollow'
                                                            : 'follow',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: user.followers
                                                                  .contains(
                                                                      userId)
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                  error: (error, stackTrace) => ErrorText(
                                    error: error.toString(),
                                  ),
                                  loading: () => const Loader(),
                                ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () => navigateToPostVideo(context,
                              notificationData.postId, notificationData, ref),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              color: notificationData.isRead
                                  ? Colors.blue.withOpacity(0.0)
                                  : Colors.blue.withOpacity(0.1),
                            ),
                            child: ref
                                .watch(getUserDataProvider(
                                    notificationData.userid))
                                .when(
                                  data: (user) {
                                    return Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image(
                                            image: NetworkImage(
                                              user.profilePic,
                                            ),
                                            fit: BoxFit.cover,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      user.username,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      notificationData.text,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  DateFormat.Hm().format(
                                                      notificationData
                                                          .datePublished),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          child: Image(
                                            image: NetworkImage(
                                              notificationData.thumbNail,
                                            ),
                                            fit: BoxFit.cover,
                                            height: 45,
                                            width: 45,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  error: (error, stackTrace) => ErrorText(
                                    error: error.toString(),
                                  ),
                                  loading: () => const Loader(),
                                ),
                          ),
                        );
                      }
                    },
                  );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
        ),
      );
    }
  }
}
