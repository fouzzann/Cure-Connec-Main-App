import 'package:cure_connect_service/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<WelcomeContent> welcomeContent = [
    WelcomeContent(
      imagePath: 'assets/welcome_page-removebg-preview.png',
      title: 'Welcome to Your Health Companion',
      description: 'Easily find and book appointments with trusted doctors near you. Your health, now just a few taps away.',
      backgroundColor: Color(0xFFECFDF5),
    ),
    WelcomeContent(
      imagePath: 'assets/welcome_page_2_-removebg-preview.png',
      title: 'Expert Care, Anytime, Anywhere',
      description: 'Access a network of top doctors and specialists, ready to provide the care you need, when you need it.',
      backgroundColor: Color(0xFFEEF2FF),
    ),
    WelcomeContent(
      imagePath: 'assets/welcome_page_3-removebg-preview.png',
      title: 'Book with Confidence',
      description: 'Seamlessly manage your health journey from booking appointments to follow-ups. Reliable, secure, and easy.',
      backgroundColor: Color(0xFFF0FDFF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemCount: welcomeContent.length,
            itemBuilder: (context, index) {
              return _buildPage(welcomeContent[index]);
            },
          ),

          
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () => Get.to(() => LoginPage()),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

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
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        width: currentIndex == index ? 32 : 12,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Color(0xFF1A59A7)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  
    
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex < welcomeContent.length - 1) {
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
                        currentIndex == welcomeContent.length - 1
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(WelcomeContent content) {
    return Container(
      color: content.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  Container(
                    height: 320,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(content.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 48),
                  
                 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          content.title,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A59A7),
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          content.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.6,
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

class WelcomeContent {
  final String imagePath;
  final String title;
  final String description;
  final Color backgroundColor;

  WelcomeContent({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}