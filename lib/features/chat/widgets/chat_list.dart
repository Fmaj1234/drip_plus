import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/core/enums/message_enum.dart';
import 'package:drip_plus/core/providers/message_reply_provider.dart';
import 'package:drip_plus/features/chat/controller/chat_controller.dart';
import 'package:drip_plus/features/chat/widgets/my_message_card.dart';
import 'package:drip_plus/features/chat/widgets/sender_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isGroup = widget.isGroupChat;
    if (isGroup) {
      return ref.watch(getGroupChatStreamProvider(widget.recieverUserId)).when(
            data: (groupSearch) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: groupSearch.length,
                itemBuilder: (BuildContext context, int index) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    messageController
                        .jumpTo(messageController.position.maxScrollExtent);
                  });
                  final groupMessageData = groupSearch[index];
                  final timeSent =
                      DateFormat.Hm().format(groupMessageData.timeSent);
                  if (!groupMessageData.isSeen &&
                      groupMessageData.recieverid ==
                          FirebaseAuth.instance.currentUser!.uid) {
                    ref
                        .read(chatControllerProvider.notifier)
                        .setChatMessageSeen(
                          context,
                          widget.recieverUserId,
                          groupMessageData.messageId,
                        );
                  }

                  if (groupMessageData.senderId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return MyMessageCard(
                      message: groupMessageData.text,
                      date: timeSent,
                      type: groupMessageData.type,
                      repliedText: groupMessageData.repliedMessage,
                      username: groupMessageData.repliedTo,
                      repliedMessageType: groupMessageData.repliedMessageType,
                      onLeftSwipe: () => onMessageSwipe(
                        groupMessageData.text,
                        true,
                        groupMessageData.type,
                      ),
                      isSeen: groupMessageData.isSeen,
                    );
                  }
                  return SenderMessageCard(
                    message: groupMessageData.text,
                    date: timeSent,
                    type: groupMessageData.type,
                    username: groupMessageData.repliedTo,
                    repliedMessageType: groupMessageData.repliedMessageType,
                    onRightSwipe: () => onMessageSwipe(
                      groupMessageData.text,
                      false,
                      groupMessageData.type,
                    ),
                    repliedText: groupMessageData.repliedMessage,
                  );
                },
              );
            },
             error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
          );
    } else {
      return ref.watch(getChatStreamProvider(widget.recieverUserId)).when(
            data: (chatSearch) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: chatSearch.length,
                itemBuilder: (BuildContext context, int index) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    messageController
                        .jumpTo(messageController.position.maxScrollExtent);
                  });
                  final chatMessageData = chatSearch[index];
                  final timeSent =
                      DateFormat.Hm().format(chatMessageData.timeSent);
                  if (!chatMessageData.isSeen &&
                      chatMessageData.recieverid ==
                          FirebaseAuth.instance.currentUser!.uid) {
                    ref
                        .read(chatControllerProvider.notifier)
                        .setChatMessageSeen(
                          context,
                          widget.recieverUserId,
                          chatMessageData.messageId,
                        );
                  }

                  if (chatMessageData.senderId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return MyMessageCard(
                      message: chatMessageData.text,
                      date: timeSent,
                      type: chatMessageData.type,
                      repliedText: chatMessageData.repliedMessage,
                      username: chatMessageData.repliedTo,
                      repliedMessageType: chatMessageData.repliedMessageType,
                      onLeftSwipe: () => onMessageSwipe(
                        chatMessageData.text,
                        true,
                        chatMessageData.type,
                      ),
                      isSeen: chatMessageData.isSeen,
                    );
                  }
                  return SenderMessageCard(
                    message: chatMessageData.text,
                    date: timeSent,
                    type: chatMessageData.type,
                    username: chatMessageData.repliedTo,
                    repliedMessageType: chatMessageData.repliedMessageType,
                    onRightSwipe: () => onMessageSwipe(
                      chatMessageData.text,
                      false,
                      chatMessageData.type,
                    ),
                    repliedText: chatMessageData.repliedMessage,
                  );
                },
              );
            },
             error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
          );
    }
  }
}
