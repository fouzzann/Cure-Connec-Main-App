import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/widgets/6_categories/nephrologist/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nephrologist extends StatefulWidget {
  const Nephrologist({super.key});

  @override
  State<Nephrologist> createState() => _NephrologistState();
}

class _NephrologistState extends State<Nephrologist> {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(child: _buildDoctorsList()),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar Widget
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFF5F5F5),
      title: Text(
        'Nephrologist',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      centerTitle: true,
    );
  }

  // StreamBuilder to fetch and display doctors list
  Widget _buildDoctorsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('isAccepted', isEqualTo: true)
          .where('category', isEqualTo: 'Nephrologist')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.mainTheme,
          ));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Nephrologists found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return NephrologistDoctorCard(
              doc: doc,
              favoritesController: favoritesController,
            );
          },
        );
      },
    );
  }
}
