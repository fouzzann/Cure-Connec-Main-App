import 'package:cure_connect_service/views/widgets/dr_carosel/dr_carrosel_details.dart';
import 'package:cure_connect_service/views/widgets/dr_carosel/grind_overlay.dart';
import 'package:flutter/material.dart';
import 'package:cure_connect_service/model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String backgroundImageUrl;
  final Doctor doctor;

  const DoctorCard({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.backgroundImageUrl,
    required this.doctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    // Define sizes based on screen width
    final double containerMargin = screenWidth < 600 ? 5.0 : 10.0;
    final double containerPadding = screenWidth < 600 ? 15.0 : 20.0;
    final double avatarRadius = screenWidth < 600 ? 20.0 : 25.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: containerMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/Doctor Card Backgorund.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          GrindOverlay(),
          // Content inside the card
          DrCarroselDetails(
              name: name,
              specialty: specialty,
              imageUrl: imageUrl,
              rating: rating,
              backgroundImageUrl: backgroundImageUrl,
              doctor: doctor),
          // Doctor image
          Positioned(
            right: containerPadding,
            top: containerPadding,
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}


