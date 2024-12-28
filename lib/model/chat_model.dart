
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderId;
  final String resiverId;
  final String message;
   Timestamp? timestamp;

  ChatModel(
      {required this.senderId,
      required this.resiverId,
      required this.message,
       this.timestamp});
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
        senderId: map['senderId'],
        resiverId: map['resiverId'],
        message: map['message'],
        timestamp: map['timestamp']);
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'resiverId': resiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
