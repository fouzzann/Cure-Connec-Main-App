import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/model/doctor_model.dart';
import 'package:cure_connect_service/views/screens/carrousel/dr_carosel.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/widgets/dr_carosel/empty_carosel.dart';
import 'package:flutter/material.dart';

class DrCarousel extends StatelessWidget {
  const DrCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        }

        var topRatedDocs = _getTopRatedDoctors(snapshot.data?.docs ?? []);

        if (topRatedDocs.isEmpty) {
          return buildEmptyState();
        }

        final List<Doctor> topRatedDoctor = _convertToDoctor(topRatedDocs);
        return _buildCarousel(topRatedDoctor);
      },
    );
  }

  List<QueryDocumentSnapshot> _getTopRatedDoctors(
      List<QueryDocumentSnapshot> docs) {
    return docs.where((doc) {
      var doctorData = doc.data() as Map<String, dynamic>;
      var ratingStr = doctorData['rating'] as String?;
      if (ratingStr == null) return false;

      try {
        double rating = double.parse(ratingStr);
        return rating >= 4.5;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  List<Doctor> _convertToDoctor(List<QueryDocumentSnapshot> docs) {
    return docs.map((doc) {
      var doctorData = doc.data() as Map<String, dynamic>;
      return Doctor.fromMap(doctorData);
    }).toList();
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.mainTheme,
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $error',
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(List<Doctor> doctors) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
      ),
      items: doctors.map((doctor) {
        return DoctorCard(
          name: doctor.fullName,
          specialty: doctor.category,
          imageUrl: doctor.image,
          rating: double.parse(doctor.rating ?? '0.0'),
          backgroundImageUrl:
              'https://media.istockphoto.com/id/1387688781/vector/modern-layer-blue-colorful-abstract-design-background.jpg?s=612x612&w=0&k=20&c=wAKGTuxGlV3ZUAMVKXUpA_Lai89TZkYa059ubw5s-8U=',
          doctor: doctor,
        );
      }).toList(),
    );
  }
}
 