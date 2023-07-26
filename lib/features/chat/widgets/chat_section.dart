import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/chat/controller/chat_controller.dart';
import 'package:drip_plus/features/chat/screens/mobile_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatSection extends ConsumerWidget {
  const ChatSection({Key? key}) : super(key: key);

  void navigateToGeneralChatScreen(BuildContext context, String uid,
      bool isGroupChat, String name, String profilePic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MobileChatScreen(
            uid: uid, isGroupChat: isGroupChat, name: name, profilePic: profilePic),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ref.watch(getChatGroupsProvider).when(
                  data: (groupDataList) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupDataList.length,
                      itemBuilder: (context, index) {
                        final groupData = groupDataList[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => navigateToGeneralChatScreen(
                                  context,
                                  groupData.groupId,
                                  true,
                                  groupData.name,
                                  groupData.groupPic),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: ListTile(
                                  title: Text(
                                    groupData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      groupData.lastMessage,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      groupData.groupPic,
                                    ),
                                    radius: 30,
                                  ),
                                  trailing: Text(
                                    DateFormat.Hm()
                                        .format(groupData.datePublished),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                ),
            ref.watch(getChatContactsProvider).when(
                  data: (chatDataList) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatDataList.length,
                      itemBuilder: (context, index) {
                        final chatContactData = chatDataList[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () => navigateToGeneralChatScreen(
                                  context,
                                  chatContactData.contactId,
                                  false,
                                  chatContactData.name,
                                  chatContactData.profilePic),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, right: 12, bottom: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        chatContactData.profilePic,
                                      ),
                                      radius: 28,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chatContactData.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            chatContactData.lastMessage,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          DateFormat.Hm()
                                              .format(chatContactData.timeSent),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            "2",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
                ),
          ],
        ),
      ),
    );
  }
}
