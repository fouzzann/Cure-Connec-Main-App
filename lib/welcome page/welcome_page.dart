
import 'package:cure_connect_service/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                buildPageContent(
                  'assets/welcome page (1).png',
                  '''Welcome to Your Health Companion\n\nEasily find and book appointments with trusted doctors near you. Your health, now just a few taps away.''',
                ),
                buildPageContent(
                  'assets/welcome page(2).png',
                   '''Expert Care, Anytime, Anywhere\n\nAccess a network of top doctors and specialists, ready to provide the care you need, when you need it.''',
                ),
                buildPageContent(
                  'assets/welcome page (3).png',
                   '''Book with Confidence\n\nSeamlessly manage your health journey from booking appointments to follow-ups. Reliable, secure, and easy.''',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(255, 26, 89, 167),
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex < 2) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Get.to(LoginPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 26, 89, 167),
                  ),
                  child: Text(
                    currentIndex == 2 ? 'Sign in ' : 'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageContent(String imagePath, String textContent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
              ),
            ),
          ),
        ),
        SizedBox(height: 56),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            textContent,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 26, 89, 167),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
