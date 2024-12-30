import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/views/screens/message%20pages/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildCancelButton(
  String docId,
  AppointmentController appointmentController,
) {
  return TextButton(
    onPressed: () async {
      await FirebaseFirestore.instance
          .collection('appointment')
          .doc(docId)
          .delete();
      await appointmentController
          .getUserAppointmentHistory(FirebaseAuth.instance.currentUser!.email!);
    },
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Text(
      'Cancel',
      style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget buildMessageButton(String uid) {
  return ElevatedButton(
    onPressed: () {
      Get.to(
          () => ChatScreen(
                druid: uid,
              ),
          transition: Transition.rightToLeftWithFade);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: const Text(
      'Message',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
