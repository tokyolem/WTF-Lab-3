import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat_list_provider.dart';
import '../../model/chat.dart';
import '../../utils/floating_bottom_sheet.dart';
import '../../utils/insets.dart';
import '../../utils/radius.dart';
import '../../utils/text_styles.dart';
import '../chat/chat_page.dart';
import 'bottom_action_sheet.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, chatList, child) => ListView.builder(
        itemCount: chatList.repository.chats.length,
        itemBuilder: (_, index) => ChatItem(
          chat: chatList.repository.orderedChats[index],
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.small,
        horizontal: Insets.large,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.small,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(Radius.large),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      chatId: chat.id,
                    ),
                  ),
                );
              },
              onLongPress: () {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: ((context) {
                    return BottomActionSheet(
                      chat: chat,
                    );
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.large,
                  vertical: Insets.medium,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Insets.large,
                      ),
                      child: Icon(chat.icon),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chat.name,
                                style: TextStyles.defaultMedium(context),
                              ),
                              Text(
                                chat.lastMessage != null
                                    ? chat.lastMessage!.time
                                    : '',
                                style: TextStyles.defaultGrey(context),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  chat.lastMessage != null
                                      ? chat.lastMessage!.text
                                      : 'Write your first message!',
                                  textAlign: TextAlign.start,
                                  style: TextStyles.defaultGrey(context),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ),
                              if (chat.isPinned)
                                const Icon(
                                  Icons.push_pin_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
