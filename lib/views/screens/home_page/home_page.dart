import 'package:cure_connect_service/views/screens/home_page/home_contend.dart';
import 'package:cure_connect_service/views/utils/custom_widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../appoiment_page.dart';
import '../message_page.dart';
import '../profile page/profile_page.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeContent(),
    AppointmentPage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar:BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
