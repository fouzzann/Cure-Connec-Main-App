import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.druid});
  final String druid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scrollController =
      ScrollController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.video_call_rounded, size: 30)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          SizedBox(
            width: 20,
          )
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/chat_bakground.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
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
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No messages yet."));
                  }
                  final listMessages = snapshot.data!.docs;
                  if (listMessages.isEmpty) {
                    return const Center(child: Text("No messages yet."));
                  }

                  // Scroll to the bottom whenever new data comes in
                  Future.delayed(Duration.zero, () {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(_scrollController
                          .position.maxScrollExtent); // Scroll to bottom
                    }
                  });

                  return ListView.builder(
                    controller:
                        _scrollController, // 2. Attach the ScrollController
                    itemCount: listMessages.length,
                    itemBuilder: (context, index) {
                      final message = listMessages[index];

                      // Format the timestamp if it's not null
                      String formattedTime = '';
                      if (message['timestamp'] != null) {
                        var timestamp = (message['timestamp'] as Timestamp)
                            .toDate(); // Convert Firestore timestamp to DateTime
                        formattedTime = DateFormat('hh:mm a').format(
                            timestamp); // Format time as 12-hour format (e.g., 10:30 AM)
                      }

                      return Align(
                        alignment: message['senderId'] != _auth.currentUser!.uid
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
                                  crossAxisAlignment: message['senderId'] !=
                                          _auth.currentUser!.uid
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message['message'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    // Display the time inside the container
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
                        color: Colors.blue[600],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            if (_messageController.text.isNotEmpty) {
                              final String chatRoomId =
                                  await chatController.createChat(
                                      widget.druid, _auth.currentUser!.uid);
                              final chatModel = ChatModel(
                                senderId: _auth.currentUser!.uid,
                                resiverId: widget.druid,
                                message: _messageController.text,
                                timestamp: null,
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
      ),
    );
  }
}
