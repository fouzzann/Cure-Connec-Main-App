import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/widgets/message_page/chat_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';

class ChatListView extends StatelessWidget {
  final ChatController chatController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ChatListView({
    super.key,
    required this.chatController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chatRooms')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mainTheme),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No chat's found.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final chatRoom = snapshot.data!.docs[index];
              final lastTime = chatRoom['lastMessageTime'] != null
                  ? DateFormat.jm().format(chatRoom['lastMessageTime'].toDate())
                  : '';

              return ChatListItem(
                chatRoom: chatRoom,
                lastTime: lastTime,
                chatController: chatController,
              );
            },
          );
        },
      ),
    );
  }
}