import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.druid,
    required this.phoneNumber,
  });

  final String druid;
  final String phoneNumber;

  Future<void> _launchDialer(String phoneNumber) async {
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
      log('Error launching dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () async {
            _launchDialer('+91$phoneNumber');
          },
          icon: const Icon(Icons.call),
        ),
        const SizedBox(width: 20),
      ],
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      title: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .where('uid', isEqualTo: druid)
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
