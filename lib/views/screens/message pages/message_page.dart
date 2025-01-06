import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/views/screens/message%20pages/chat_screen.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ChatController chatController = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar( 
        toolbarHeight: 80,
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.mainTheme,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  leading: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search....',
                  controller: _searchController,
                  onChanged: (value) {
                    chatController.updateSearchQuery(value);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .where('userId', isEqualTo: _auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color:  AppColors.mainTheme ),
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
                var chatRooms = snapshot.data!.docs;
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final data = chatRooms[index];
                    String lastTime = '';
                    if (data['lastMessageTime'] != null) {
                      lastTime = DateFormat.jm()
                          .format(data['lastMessageTime'].toDate());
                    }

                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('doctors')
                          .where('uid', isEqualTo: data['drId'])
                          .limit(1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: const ListTile(
                              title: Text("Loading..."),
                            ),
                          );
                        }
                        final doctorData = snapshot.data?.docs[0];

                        return Obx(() {
                          if (chatController.searchQuery.isNotEmpty &&
                              doctorData != null &&
                              !doctorData['fullName']
                                  .toString()
                                  .toUpperCase()
                                  .contains(chatController.searchQuery.value)) {
                            return SizedBox.shrink();
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Get.to(
                                  () => ChatScreen(druid: data['drId']),
                                  transition: Transition.rightToLeftWithFade,
                                );
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  doctorData != null ? doctorData['image'] : '',
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                              title: Text(
                                doctorData != null
                                    ? doctorData['fullName']
                                    : 'Doctor',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              subtitle: Text(
                                data['lastMessage'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              trailing: Text(
                                lastTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mainTheme,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
