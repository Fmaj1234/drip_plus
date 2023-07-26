import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/features/profile/widgets/profile_like_widget.dart';
import 'package:drip_plus/features/profile/widgets/profile_post_widget.dart';
import 'package:drip_plus/features/profile/widgets/profile_save_widget.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralProfileScreen extends ConsumerWidget {
  final String uid;
  const GeneralProfileScreen({
    super.key,
    required this.uid,
  });

  void signOut(BuildContext context, WidgetRef ref) {
    ref.read(profileControllerProvider.notifier).signOut(context);
  }

  void followUser(WidgetRef ref, UserModel userModel) {
    ref.read(profileControllerProvider.notifier).followUser(userModel);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pUser = ref.watch(userProvider)!;
    final isGuest = !pUser.isAuthenticated;
    final publisherId = pUser.uid;
    return Scaffold(
      body: SafeArea(
        child: ref.watch(getUserDataProvider(uid)).when(
              data: (user) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SafeArea(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.arrow_back,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          user.username,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.more_vert,
                                          size: 24,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image(
                                            image: NetworkImage(
                                              user.profilePic,
                                            ),
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          ' @${user.username}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    user.following.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Following",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    user.followers.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Followers",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${user.totalLikesCount}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Likes",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (!isGuest)
                                                publisherId == uid
                                                    ? Material(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: InkWell(
                                                          onTap: () => signOut(
                                                              context, ref),
                                                          child: Container(
                                                            height: 40,
                                                            width: 120,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        12),
                                                            child: const Center(
                                                              child: Text(
                                                                "Sign Out",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Material(
                                                        color: user.followers
                                                                .contains(
                                                                    pUser.uid)
                                                            ? Pallete.anotherGreyColor
                                                            : Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: InkWell(
                                                          onTap: () =>
                                                              followUser(
                                                                  ref, user),
                                                          child: Container(
                                                            height: 40,
                                                            width: 120,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        12),
                                                            child: Center(
                                                              child: Text(
                                                                user.followers
                                                                        .contains(
                                                                            pUser.uid)
                                                                    ? 'unfollow'
                                                                    : 'follow',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: user
                                                                          .followers
                                                                          .contains(pUser
                                                                              .uid)
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white24
                                                        .withOpacity(0.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.black54),
                                                  ),
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      size: 24,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white24
                                                        .withOpacity(0.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.black54),
                                                  ),
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.shopping_bag,
                                                      size: 24,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white24
                                                        .withOpacity(0.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.black54),
                                                  ),
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.group_sharp,
                                                      size: 24,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Text(
                                            user.bio,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12,
                                        bottom: 12,
                                        left: 12,
                                        top: 12),
                                    child: Container(
                                      height: 40,
                                      width: 380,
                                      decoration: BoxDecoration(
                                        color: Pallete.anotherGreyColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            height: 40,
                                            width: 200,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Search the music",
                                                hintStyle: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Icon(
                                              Icons.search,
                                              size: 20,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: DefaultTabController(
                  length: 5,
                  child: Column(
                    children: [
                      const TabBar(
                        // isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black26,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.grid_view_rounded, size: 24),
                          ),
                          Tab(
                            icon: Icon(Icons.shopping_bag, size: 24),
                          ),
                          Tab(
                            icon: Icon(Icons.bookmark, size: 24),
                          ),
                          Tab(
                            icon: Icon(Icons.groups_sharp, size: 24),
                          ),
                          Tab(
                            icon: Icon(Icons.favorite, size: 24),
                          ),
                        ],
                      ),
                      Flexible(
                        flex: 1,
                        child: TabBarView(
                          children: [
                            ProfilePostWidget(profileuid: uid),
                            ProfilePostWidget(profileuid: uid),
                            ProfileSaveWidget(profileuid: uid),
                            ProfilePostWidget(profileuid: uid),
                            ProfileLikeWidget(profileuid: uid),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, stackTrace) => ErrorText(
                                      error: error.toString(),
                                    ),
                                    loading: () => const Loader(),
            ),
      ),
    );
  }
}
