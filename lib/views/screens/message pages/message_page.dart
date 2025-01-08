import 'package:cure_connect_service/views/widgets/message_page/chat_list_view.dart';
import 'package:cure_connect_service/views/widgets/message_page/custom_app_bar.dart';
import 'package:cure_connect_service/views/widgets/message_page/search_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cure_connect_service/controllers/chat_controller.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final ChatController chatController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomMessageAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SearchContainer(
              searchController: _searchController,
              onSearchChanged: (value) {
                chatController.updateSearchQuery(value);
              },
            ),
            ChatListView(chatController: chatController),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
