// profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [

          Container(
            height: 300,
            width: 3000,
            decoration: BoxDecoration(
              color: const Color(0xFF4A78FF),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/Donex Fiance.webp',
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Donex fiance', // Replace 'User Name' with the actual user's name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextButton(onPressed: (){},child: Text( 'Edit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                     ) ],
                    ),Row(
                      children: [
                      Icon(Icons.edit,color: Colors.white,size: 15,)
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // List section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Color(0xFF4A78FF)),
                  title: const Text("Account"),
                  onTap: () {
                    // Handle tap for "Account"
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shield,color: Color(0xFF4A78FF)),
                  title: const Text("Privacy and Policy"),
                  onTap: () {
                    // Handle tap for "Notifications"
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.padding_rounded, color: Color(0xFF4A78FF)),
                  title: const Text("Terms and Conditions"),
                  onTap: () {
                    // Handle tap for "Settings"
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help, color: Color(0xFF4A78FF)),
                  title: const Text("Help & Support"),
                  onTap: () {
                    // Handle tap for "Help & Support"
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout",style: TextStyle(color: Colors.red),),
                  onTap: () {
                    // Handle tap for "Logout"
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Text('Version 1.0.0',
                      style: TextStyle(fontSize: 17,color: Colors.grey),),
                    ],
                  ),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
