import 'package:cure_connect_service/views/widgets/welcome_page/bottom_bar_widget.dart';
import 'package:cure_connect_service/views/widgets/welcome_page/welcome_contant.dart';
import 'package:cure_connect_service/views/widgets/welcome_screen/skip_button.dart';
import 'package:cure_connect_service/views/widgets/welcome_screen/welcome_page_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../authentication/login.dart';
import '../../../controllers/welcome_page_controller.dart';

class WelcomePage extends StatelessWidget {
  final PageController _pageController = PageController();
  final WelcomePageController controller = Get.put(WelcomePageController());

  WelcomePage({super.key});

  void _handleNavigation() {
    if (controller.currentIndex.value < welcomeContent.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Get.to(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => controller.changePage(index),
            itemCount: welcomeContent.length,
            itemBuilder: (context, index) {
              return WelcomeContentView(content: welcomeContent[index]);
            },
          ),
          SkipButton(),
          WelcomeBottomBar(
            pageCount: welcomeContent.length,
            controller: controller,
            onNavigate: _handleNavigation,
          ),
        ],
      ),
    );
  }
}