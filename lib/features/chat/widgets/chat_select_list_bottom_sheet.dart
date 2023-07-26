import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/chat/controller/chat_controller.dart';
import 'package:drip_plus/features/chat/screens/mobile_chat_screen.dart';
import 'package:drip_plus/features/profile/controller/profile_controller.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ChatSelectListBottomSheet extends ConsumerStatefulWidget {
  const ChatSelectListBottomSheet({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<ChatSelectListBottomSheet> createState() =>
      _ChatSelectListBottomSheetState();
}

class _ChatSelectListBottomSheetState
    extends ConsumerState<ChatSelectListBottomSheet> {
  bool isTyping = false;
  late String typedUser;
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void navigateToGeneralProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/general-profile/$uid');
  }

  void navigateToGeneralChatScreen(BuildContext context, String uid,
      bool isGroupChat, String name, String profilePic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MobileChatScreen(
            uid: uid,
            isGroupChat: isGroupChat,
            name: name,
            profilePic: profilePic),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String searchValue = _messageController.text.trim();
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 221, 221),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Connect with the world",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          const Divider(color: Colors.grey, thickness: 0.8),
          Container(
            margin: const EdgeInsets.only(bottom: 12, top: 12),
            height: 45,
            decoration: BoxDecoration(
              color: Pallete.anotherGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                // onFieldSubmitted: (value) {
                //   if (searchValue != null) {
                //     setState(() {
                //       searchValue = value;
                //     });
                //   }
                // },
                onChanged: (val) {
                  if (val.isNotEmpty || searchValue == "") {
                    setState(() {
                      isTyping = true;
                    });
                  } else {
                    setState(() {
                      isTyping = false;
                      // typedUser = val;
                    });
                  }
                },
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  //fillColor: Colors.amber,
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
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 18),
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
              ? ref.watch(searchChatUsersProvider(searchValue)).when(
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
                                onTap: () => navigateToGeneralProfileScreen(
                                    context, searchData.uid),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
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
                                onTap: () => navigateToGeneralProfileScreen(
                                    context, searchData.uid),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
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
                              Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                                child: GestureDetector(
                                  onTap: () => navigateToGeneralChatScreen(
                                      context,
                                      searchData.uid,
                                      false,
                                      searchData.username,
                                      searchData.profilePic),
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: const Center(
                                      child: Text(
                                        "Message",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
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
              : Expanded(
                  child: ref.watch(userFollowersProvider).when(
                        data: (userModel) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: userModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            final searchData = userModel[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => navigateToGeneralProfileScreen(
                                        context, searchData.uid),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
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
                                    onTap: () => navigateToGeneralProfileScreen(
                                        context, searchData.uid),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
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
                                  Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    child: GestureDetector(
                                      onTap: () => navigateToGeneralChatScreen(
                                          context,
                                          searchData.uid,
                                          false,
                                          searchData.username,
                                          searchData.profilePic),
                                      child: Container(
                                        height: 40,
                                        width: 120,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        child: const Center(
                                          child: Text(
                                            "Message",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
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
                        error: (error, stackTrace) {
                          print(error);
                          return ErrorText(
                            error: error.toString(),
                          );
                        },
                        loading: () => const Loader(),
                      )),
        ],
      ),
    );
  }
}
