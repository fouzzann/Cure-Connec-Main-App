import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/pages/home_page/home_contend.dart';
import 'package:cure_connect_service/pages/top_rated_doctors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appoiment_page.dart';
import '../message_page.dart';
import '../profile_page.dart';


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
      bottomNavigationBar: Container(
        color: const Color(0xFFF5F5F5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xFF4A78FF),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Appointment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

 class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String backgroundImageUrl;

  const DoctorCard({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.backgroundImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          image: DecorationImage(
              image: NetworkImage(
                  'https://media.istockphoto.com/id/1387688781/vector/modern-layer-blue-colorful-abstract-design-background.jpg?s=612x612&w=0&k=20&c=wAKGTuxGlV3ZUAMVKXUpA_Lai89TZkYa059ubw5s-8U='))),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4A78FF).withOpacity(0.2),
                  const Color(0xFF4A78FF).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      specialty,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 223, 223, 223),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A78FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}

