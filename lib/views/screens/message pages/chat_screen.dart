import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/model/chat_model.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.druid, required this.phoneNumber});
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
  Future<void> _launchDialer(String phoneNumber) async {
    // Format the phone number to ensure it's properly encoded
    final formattedNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri url = Uri(
      scheme: 'tel',
      path: formattedNumber,
    );

    try {
      if (!await launchUrl(url)) {
        throw 'Could not launch dialer';
      }
    } catch (e) {
      // Show error dialog to user
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Could not launch phone dialer: ${e.toString()}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      log('Error launching dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                _launchDialer('+91${widget.phoneNumber}');
              },
              icon: Icon(Icons.call)),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .where('uid', isEqualTo: widget.druid)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }

            final doctorData = snapshot.data?.docs[0];
            if (doctorData == null) {
              return const Text("Doctor");
            }

            return Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(doctorData['image']),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    doctorData['fullName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .doc("${_auth.currentUser!.uid}_${widget.druid}")
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                final listMessages = snapshot.data!.docs;

                // Scroll to the bottom whenever new data comes in
                Future.delayed(Duration.zero, () {
                  if (_scrollController.hasClients) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  }
                });

// Inside your ListView.builder
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: listMessages.length,
                  itemBuilder: (context, index) {
                    final message = listMessages[index];

                    // Safely handle null timestamps
                    String formattedDate = '';
                    String formattedTime = '';
                    DateTime? timestamp;
                    if (message['timestamp'] != null) {
                      timestamp = (message['timestamp'] as Timestamp).toDate();
                      formattedDate =
                          DateFormat('MMMM dd, yyyy').format(timestamp);
                      formattedTime = DateFormat('hh:mm a').format(timestamp);
                    }

                    // Check if the date is different from the previous message
                    bool showDateHeader = true;
                    if (index > 0) {
                      final previousMessage = listMessages[index - 1];
                      if (previousMessage['timestamp'] != null) {
                        var prevTimestamp =
                            (previousMessage['timestamp'] as Timestamp)
                                .toDate();
                        showDateHeader =
                            DateFormat('yyyy-MM-dd').format(prevTimestamp) !=
                                DateFormat('yyyy-MM-dd')
                                    .format(timestamp ?? DateTime.now());
                      }
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
                          alignment:
                              message['senderId'] != _auth.currentUser!.uid
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:
                                  message['senderId'] != _auth.currentUser!.uid
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: message['senderId'] !=
                                            _auth.currentUser!.uid
                                        ? Colors.grey[200]
                                        : Colors.blue[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['message'] ?? '',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      if (timestamp != null)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
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
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: AppColors.mainTheme, width: 2)),
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
                        shape: BoxShape.circle, color: AppColors.mainTheme),
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          String messageText = _messageController.text.trim();
                          if (messageText.isNotEmpty) {
                            final String chatRoomId =
                                await chatController.createChat(
                                    widget.druid, _auth.currentUser!.uid);
                            final chatModel = ChatModel(
                              senderId: _auth.currentUser!.uid,
                              resiverId: widget.druid,
                              message: messageText,
                              timestamp: Timestamp.now(),
                            );
                            chatController.sendMessage(chatModel, chatRoomId);
                            _messageController.clear();

                            if (_scrollController.hasClients) {
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent);
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
          ),
        ],
      ),
    );
  }
}
