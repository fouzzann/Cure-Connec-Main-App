import 'dart:ui';

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

final List<WelcomeContent> welcomeContent = [
    WelcomeContent(
      imagePath: 'assets/welcome_page-removebg-preview.png',
      title: 'Welcome to Your Health Companion',
      description:
          'Easily find and book appointments with trusted doctors near you. Your health, now just a few taps away.',
      backgroundColor: Color(0xFFECFDF5),
    ),
    WelcomeContent(
      imagePath: 'assets/welcome_page_2_-removebg-preview.png', 
      title: 'Expert Care, Anytime, Anywhere',
      description:
          'Access a network of top doctors and specialists, ready to provide the care you need, when you need it.',
      backgroundColor: Color(0xFFEEF2FF),
    ),
    WelcomeContent(
      imagePath: 'assets/welcome_page_3-removebg-preview.png',
      title: 'Book with Confidence',
      description:
          'Seamlessly manage your health journey from booking appointments to follow-ups. Reliable, secure, and easy.',
      backgroundColor: Color(0xFFF0FDFF),
    ),
  ];
 