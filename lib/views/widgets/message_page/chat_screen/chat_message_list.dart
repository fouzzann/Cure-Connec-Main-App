import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_message_bubble.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.scrollController,
    required this.auth,
    required this.druid,
  });

  final ScrollController scrollController;
  final FirebaseAuth auth;
  final String druid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chatRooms')
          .doc("${auth.currentUser!.uid}_$druid")
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        final listMessages = snapshot.data!.docs;

        Future.delayed(Duration.zero, () {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });

        return ListView.builder(
          controller: scrollController,
          itemCount: listMessages.length,
          itemBuilder: (context, index) {
            final message = listMessages[index];
            final prevMessage = index > 0 ? listMessages[index - 1] : null;
            
            return ChatMessageBubble(
              message: message,
              prevMessage: prevMessage,
              currentUserId: auth.currentUser!.uid,
            );
          },
        );
      },
    );
  }
}