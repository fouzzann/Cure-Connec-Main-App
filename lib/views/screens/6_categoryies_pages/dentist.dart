import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/widgets/6_categories/dentist/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Dentist extends StatefulWidget {
  const Dentist({super.key});

  @override
  State<Dentist> createState() => _DentistState();
}

class _DentistState extends State<Dentist> {
  final FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: buildAppBar(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(child: buildDoctorsList()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF5F5F5),
      title: const Text(
        'Dentist',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      centerTitle: true,
    );
  }

  Widget buildDoctorsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('isAccepted', isEqualTo: true)
          .where('category', isEqualTo: 'Dentist')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xFF4A78FF),
          ));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No dentists found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return DentistDoctorCard(doc: doc);
          },
        );
      },
    );
  }
}
