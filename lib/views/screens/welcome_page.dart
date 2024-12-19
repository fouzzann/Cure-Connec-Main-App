import 'package:cure_connect_service/authentication/login.dart';
import 'package:cure_connect_service/controllers/welcome_page_controller.dart';
import 'package:cure_connect_service/widgets/welcome_screen/skip_button.dart';
import 'package:cure_connect_service/widgets/welcome_screen/welcome_page_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  final PageController _pageController = PageController();
  final WelcomePageController controller = Get.put(WelcomePageController());

  Widget buildPage(WelcomeContent content) {
    return Container(
      color: content.backgroundColor,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            content.imagePath,
            height: 250,
          ),
          SizedBox(height: 32),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A59A7),
            ),
          ),
          SizedBox(height: 16),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
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
              return buildPage(welcomeContent[index]);
            },
          ),  
          SkipButton(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      welcomeContent.length,
                      (index) => Obx(
                        () => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          height: 4,
                          width:
                              controller.currentIndex.value == index ? 32 : 12,
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? Color(0xFF1A59A7)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56, 
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (controller.currentIndex.value <
                              welcomeContent.length - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          } else {
                            Get.to(() => LoginPage());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A59A7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          controller.currentIndex.value ==
                                  welcomeContent.length - 1
                              ? 'Get Started'
                              : 'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
