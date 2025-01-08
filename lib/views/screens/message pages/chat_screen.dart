import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/views/widgets/message_page/chat_screen/chat_app_bar.dart';
import 'package:cure_connect_service/views/widgets/message_page/chat_screen/chat_input_field.dart';
import 'package:cure_connect_service/views/widgets/message_page/chat_screen/chat_message_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.druid, required this.phoneNumber});
  final String druid;
  final String phoneNumber;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(
        druid: widget.druid,
        phoneNumber: widget.phoneNumber,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageList(
              scrollController: _scrollController,
              auth: _auth,
              druid: widget.druid,
            ),
          ),
          ChatInputField(
            messageController: _messageController,
            scrollController: _scrollController,
            chatController: chatController,
            auth: _auth,
            druid: widget.druid,
          ),
        ],
      ),
    );
  }
} 