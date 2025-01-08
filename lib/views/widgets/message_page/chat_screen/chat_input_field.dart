import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/model/chat_model.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.messageController,
    required this.scrollController,
    required this.chatController,
    required this.auth,
    required this.druid,
  });

  final TextEditingController messageController;
  final ScrollController scrollController;
  final ChatController chatController;
  final FirebaseAuth auth;
  final String druid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.mainTheme, width: 2),
                ),
                labelText: "Type Message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainTheme,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    String messageText = messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      final String chatRoomId = await chatController.createChat(
                        druid,
                        auth.currentUser!.uid,
                      );
                      final chatModel = ChatModel(
                        senderId: auth.currentUser!.uid,
                        resiverId: druid,
                        message: messageText,
                        timestamp: Timestamp.now(),
                      );
                      chatController.sendMessage(chatModel, chatRoomId);
                      messageController.clear();

                      if (scrollController.hasClients) {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}