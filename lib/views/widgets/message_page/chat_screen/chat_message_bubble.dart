import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.prevMessage,
    required this.currentUserId,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> message;
  final QueryDocumentSnapshot<Map<String, dynamic>>? prevMessage;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    String formattedTime = '';
    DateTime? timestamp;
    
    if (message['timestamp'] != null) {
      timestamp = (message['timestamp'] as Timestamp).toDate();
      formattedDate = DateFormat('MMMM dd, yyyy').format(timestamp);
      formattedTime = DateFormat('hh:mm a').format(timestamp);
    }

    bool showDateHeader = true;
    if (prevMessage != null && prevMessage!['timestamp'] != null) {
      var prevTimestamp = (prevMessage!['timestamp'] as Timestamp).toDate();
      showDateHeader = DateFormat('yyyy-MM-dd').format(prevTimestamp) !=
          DateFormat('yyyy-MM-dd').format(timestamp ?? DateTime.now());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDateHeader && timestamp != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        Align(
          alignment: message['senderId'] != currentUserId
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: message['senderId'] != currentUserId
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: message['senderId'] != currentUserId
                        ? Colors.grey[200]
                        : Colors.blue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['message'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      if (timestamp != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            formattedTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
