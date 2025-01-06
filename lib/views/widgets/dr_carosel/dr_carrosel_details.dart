import 'package:cure_connect_service/model/doctor_model.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrCarroselDetails extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String backgroundImageUrl;
  final Doctor doctor;

  DrCarroselDetails(
      {super.key,
      required this.name,
      required this.specialty,
      required this.imageUrl,
      required this.rating,
      required this.backgroundImageUrl,
      required this.doctor});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double containerPadding = screenWidth < 600 ? 15.0 : 20.0; 
    final double nameSize = screenWidth < 600 ? 20.0 : 24.0;
    final double specialtySize = screenWidth < 600 ? 14.0 : 16.0;
    final double starSize = screenWidth < 600 ? 16.0 : 20.0;
    return Padding(
      padding: EdgeInsets.all(containerPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Doctor details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: nameSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                specialty,
                style: TextStyle(
                  fontSize: specialtySize,
                  color: const Color.fromARGB(255, 223, 223, 223),
                ),
              ),
            ],
          ),
          // Rating and button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: buildRatingStars(rating, starSize),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => DoctorProfileView(
                      data: doctor.toMap(), 
                    ),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A78FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth < 600 ? 12.0 : 16.0,
                    vertical: screenWidth < 600 ? 8.0 : 10.0,
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth < 600 ? 12.0 : 14.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  // Helper method to build rating stars
  List<Widget> buildRatingStars(double rating, double starSize) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: Colors.amber, size: starSize));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(Icon(Icons.star_half, color: Colors.amber, size: starSize));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.amber, size: starSize));
      }
    }
    return stars;
  }