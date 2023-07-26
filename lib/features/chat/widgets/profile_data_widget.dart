import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDataWidget extends ConsumerWidget {
  final String uid;
  final bool isGroupChat;
  const ProfileDataWidget(
      {super.key, required this.uid, required this.isGroupChat});

      void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ref.watch(getUserDataProvider(uid)).when(
            data: (profileData) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: NetworkImage(
                              profileData.profilePic,
                            ),
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '@${profileData.username}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${profileData.followers.length.toString()} followers -',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${profileData.totalLikesCount} likes",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Material(
                          color: Pallete.anotherGreyColor,
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () => navigateToGeneralProfileScreen(
                                context, profileData.uid),
                            child: Container(
                              height: 40,
                              width: 150,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: const Center(
                                child: Text(
                                  "View Profile",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
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
    );
  }
}
