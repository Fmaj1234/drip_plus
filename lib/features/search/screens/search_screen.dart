import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/auth/screens/welcome_screen.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/features/search/controller/search_controller.dart';
import 'package:drip_plus/features/search/widgets/search_items_categories_widget.dart';
import 'package:drip_plus/features/search/widgets/search_product_images_slider_widget.dart';
import 'package:drip_plus/features/search/widgets/search_spotlight_item_widget.dart';
import 'package:drip_plus/features/search/widgets/search_top_posts_item_widget.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool isTyping = false;
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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

  void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

  void followUser(WidgetRef ref, UserModel userModel) {
    ref.read(profileControllerProvider.notifier).followUser(userModel);
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final userId = user.uid;
    String searchValue = _messageController.text.trim();
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
    }
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Pallete.anotherGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: _messageController,
                        onChanged: (val) {
                          if (val.isNotEmpty || searchValue == "") {
                            setState(() {
                              isTyping = true;
                            });
                          } else {
                            setState(() {
                              isTyping = false;
                            });
                          }
                        },
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _messageController.text = "";
                                isTyping = false;
                              });
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Search here...",
                          hintStyle: const TextStyle(
                              color: Colors.black54, fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  isTyping
                      ? ref.watch(searchUsersProvider(searchValue)).when(
                            data: (search) => ListView.builder(
                              shrinkWrap: true,
                              itemCount: search.length,
                              itemBuilder: (BuildContext context, int index) {
                                final searchData = search[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  margin: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            navigateToGeneralProfileScreen(
                                                context, searchData.uid),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image(
                                            image: NetworkImage(
                                              searchData.profilePic,
                                            ),
                                            fit: BoxFit.cover,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            navigateToGeneralProfileScreen(
                                                context, searchData.uid),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchData.username,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Followed by ${searchData.followers.length} people',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      if (userId == searchData.uid)
                                        const SizedBox()
                                      else
                                        Material(
                                          color: searchData.followers
                                                  .contains(userId)
                                              ? Pallete.anotherGreyColor
                                              : Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: InkWell(
                                            onTap: () =>
                                                followUser(ref, searchData),
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 12),
                                              child: Center(
                                                child: Text(
                                                  searchData.followers
                                                          .contains(userId)
                                                      ? 'unfollow'
                                                      : 'follow',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: searchData.followers
                                                            .contains(userId)
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            error: (error, stackTrace) => ErrorText(
                              error: error.toString(),
                            ),
                            loading: () => const Loader(),
                          )
                      : Column(
                          children: [
                            SearchItemsCategoriesWidget(),
                            const SizedBox(height: 8),
                            const SearchProductImagesSliderWidget(),
                            const SizedBox(height: 16),
                            const SearchSpotlightItemWidget(),
                            const SizedBox(height: 16),
                            const SearchTopPostsItemWidget(),
                            const SizedBox(height: 16),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
