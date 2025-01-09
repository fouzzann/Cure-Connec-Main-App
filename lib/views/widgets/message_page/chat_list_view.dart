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
            return _buildErrorState(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildChatList(snapshot);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainTheme.withOpacity(0.1),
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 40,
                color: AppColors.mainTheme,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Conversations Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start a conversation with your healthcare provider',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.mainTheme,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading chats...',
            style: TextStyle(
              color: AppColors.mainTheme,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[400],
              size: 40,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
  }
}