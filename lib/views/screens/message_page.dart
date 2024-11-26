import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  MessagePage({super.key});

  // Ensuring all fields are non-null or nullable where necessary
  final List<Map<String, dynamic>> messages = [
    {
      'userName': 'Dr. John',
      'specialty': 'Cardiologist',
      'message': 'Hello, I would like to schedule an appointment.',
      'time': '2 min ago',
      'unread': true,
      'online': true,
    },
    {
      'userName': 'Dr. Sarah',
      'specialty': 'Neurologist',
      'message': 'Please send me your medical history.',
      'time': '1 hour ago',
      'unread': false,
      'online': true,
    },
    {
      'userName': 'Dr. Michael',
      'specialty': 'Dentist',
      'message': 'Your appointment is confirmed for tomorrow.',
      'time': '2 hours ago',
      'unread': true,
      'online': false,
    },
    {
      'userName': 'Dr. Emma',
      'specialty': 'Dermatologist',
      'message': 'Can you provide your availability next week?',
      'time': 'Yesterday',
      'unread': false,
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey[600]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: (message['unread'] ?? false)
                      ? Border.all(color: const Color(0xFF0EA5E9), width: 2)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message['userName']?[0] ?? '?',
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (message['online'] ?? false)
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                message['userName'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              Text(
                                message['time'] ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message['specialty'] ?? 'Unknown Specialty',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            message['message'] ?? 'No message available',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: (message['unread'] ?? false)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF0EA5E9),
        child: const Icon(Icons.add_comment_outlined, color: Colors.white),
      ),
    );
  }
}
