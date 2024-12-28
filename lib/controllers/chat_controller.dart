import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/model/chat_model.dart';
import 'package:get/get.dart';


class ChatController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chatRooms = [];
  var searchQuery = ''.obs;
  Future<String> createChat(String drId, String userId) async {
    final String chatRoomid = '${userId}_${drId}';
    final DocumentSnapshot getDoc =
        await db.collection('chatRooms').doc(chatRoomid).get();
    if (!getDoc.exists) {
      db.collection('chatRooms').doc(chatRoomid).set({
        'drId': drId,
        'userId': userId,
        'lastMessage': '',
        'lastMessageTime': '',
      });
    }
    return chatRoomid;
  }

  sendMessage(ChatModel chatModel, String chatRoomId) async {
    try {
      await db
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .add({
        'senderId': chatModel.senderId,
        'resiverId': chatModel.resiverId,
        'message': chatModel.message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await db.collection('chatRooms').doc(chatRoomId).update({
        'lastMessage': chatModel.message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // pickChatRooms(String userUid) async {
  //   try {
  //   } catch (e) {
  //     log(e.toString());   
  //   }
  // }

   void updateSearchQuery(String query) {
    searchQuery.value = query.toUpperCase();
  }
  void clearSearch() { 
    searchQuery.value = '';
  }
}
