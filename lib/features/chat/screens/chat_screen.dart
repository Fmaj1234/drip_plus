import 'package:drip_plus/features/chat/widgets/chat_section.dart';
import 'package:drip_plus/features/chat/widgets/chat_select_list_bottom_sheet.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  void navigateToCreateGroupScreen(BuildContext context) {
    Routemaster.of(context).push('/createGroup');
  }

  void bottomSheetChatSelectList(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const ChatSelectListBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Container(
        decoration: const BoxDecoration(
          color: Pallete.whiteColor,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        Text(
                          "Chats",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                bottomSheetChatSelectList(context);
                              },
                              child: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => navigateToCreateGroupScreen(context),
                              child: const Icon(
                                Icons.group_add_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8, right: 12, bottom: 12),
                    child: Container(
                      height: 40,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Pallete.anotherGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search the music",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black87,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "Chats"),
                      Tab(text: "Group Chats"),
                      Tab(text: "Business Chats"),
                      Tab(text: "Business Queries"),
                      Tab(text: "Requests"),
                    ],
                  ),
                  const Flexible(
                    flex: 1,
                    child: TabBarView(
                      children: [
                        ChatSection(),
                        ChatSection(),
                        ChatSection(),
                        ChatSection(),
                        ChatSection(),
                        ChatSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
