import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/widgets/6_categories/pediatrician/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pediatrician extends StatelessWidget {
  const Pediatrician({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = Get.put(FavoritesController());

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Color(0xFFF5F5F5),
      body: _buildBody(favoritesController),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFF5F5F5),
      title: Text(
        'Pediatrician',
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

  Widget _buildBody(FavoritesController favoritesController) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(child: _buildDoctorsList(favoritesController)),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorsList(FavoritesController favoritesController) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('isAccepted', isEqualTo: true)
          .where('category', isEqualTo: 'Pediatrician')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Pediatrician found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return PediatricianDoctorCard(
              doc: doc,
              favoritesController: favoritesController,
            );
          },
        );
      },
    );
  }
}
