import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';
import 'package:cure_connect_service/views/screens/message%20pages/chat_screen.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';

class ChatListItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> chatRoom;
  final String lastTime;
  final ChatController chatController;

  const ChatListItem({
    super.key,
    required this.chatRoom,
    required this.lastTime,
    required this.chatController,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('uid', isEqualTo: chatRoom['drId'])
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: const ListTile(title: Text("Loading...")),
          );
        }
        
        final doctorData = snapshot.data?.docs[0];
        if(doctorData!.exists){
          return Center(
            child: Text('no data'),
          );
        }
        String? no=doctorData?['contact'].toString();
        return Obx(() {
          if (chatController.searchQuery.isNotEmpty &&
              doctorData != null &&
              !doctorData['fullName']
                  .toString()
                  .toUpperCase()
                  .contains(chatController.searchQuery.value)) {
            return const SizedBox.shrink();
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
                  () => ChatScreen(druid: chatRoom['drId'],phoneNumber:no! ,),
                  transition: Transition.rightToLeftWithFade,
                );
              },
              leading: CircleAvatar( 
                radius: 25,
                backgroundImage: NetworkImage(
                  doctorData != null? doctorData['image'] : '',
                ),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(
                doctorData != null ? doctorData['fullName'] : 'Doctor',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              subtitle: Text(
                chatRoom['lastMessage'],
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
  }
}