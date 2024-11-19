import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
   MessagePage({super.key});

  // Sample data for messages
  final List<Map<String, dynamic>> messages = [
    {
      'userImage': 'assets/user1.jpg', // Add the path of your image asset
      'userName': 'Dr. John',
      'message': 'Hello, I would like to schedule an appointment.',
    },
    {
      'userImage': 'assets/user2.jpg', // Add the path of your image asset
      'userName': 'Dr. Sarah',
      'message': 'Please send me your medical history.',
    },
    {
      'userImage': 'assets/user3.jpg', // Add the path of your image asset
      'userName': 'Dr. Michael',
      'message': 'Your appointment is confirmed for tomorrow.',
    },
    {
      'userImage': 'assets/user4.jpg', // Add the path of your image asset
      'userName': 'Dr. Emma',
      'message': 'Can you provide your availability next week?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: Size(0, 80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF5F5F5),
          title: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: const Text(
              'Messages',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // User Image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    // image: DecorationImage(
                    //   image: AssetImage(message['']),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                const SizedBox(width: 16),
                // Message Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['userName'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message['message'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
