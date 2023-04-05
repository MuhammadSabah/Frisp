import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/message.dart';
import 'package:food_recipe_final/src/models/user_model.dart';
import 'package:food_recipe_final/src/features/chat/widgets/chat_messages.dart';
import 'package:food_recipe_final/src/providers/message_provider.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final TextEditingController _sendMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    _sendMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      key:  const Key('chatMessagesScreen'),
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: settingsManager.darkMode ? Colors.white : Colors.black,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: Text(
          widget.user.userName,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.more_horiz,
              color: settingsManager.darkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ChatMessages(
                scrollController: _scrollController,
                userId: widget.user.id,
                currentUserId: FirebaseAuth.instance.currentUser!.uid,
              ),
            ),
          ),
          // Text Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              key:    const Key('chatMessagesScreen_textField'),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              controller: _sendMessageController,
              cursorColor: kOrangeColor,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              minLines: null,
              maxLines: null,
              decoration: InputDecoration(
                counterText: ' ',
                prefixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.add,
                    color: kOrangeColor,
                  ),
                ),
                suffixIcon: IconButton(
                  key:   const Key('chatMessagesScreen_sendButton'),
                  splashRadius: 20,
                  onPressed: () async {
                    // !: Send message.
                    if (_sendMessageController.text.isNotEmpty) {
                      final message = Message(
                        receiverId: widget.user.id,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        messageText: _sendMessageController.text,
                        sentAt: DateTime.now(),
                        isSeen: false,
                        // type: MessageEnum.text,
                      );
                      messageProvider.sendMessage(
                        message,
                        widget.user.id,
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                      _sendMessageController.clear();
                      _scrollToBottom();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kOrangeColor,
                  ),
                ),
                fillColor: settingsManager.darkMode ? kGreyColor : kGreyColor4,
                filled: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18).copyWith(right: 0),
                hintText: 'Message...',
                hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 15,
                      color: settingsManager.darkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                focusedErrorBorder: kFocusedErrorBorder,
                errorBorder: kErrorBorder,
                enabledBorder: kEnabledBorder,
                focusedBorder: kFocusedBorder,
                border: kBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
