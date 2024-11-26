import 'package:carousel_slider/carousel_slider.dart';
import 'package:cure_connect_service/views/utils/top_rated_dr_data.dart';
import 'package:cure_connect_service/widgets/dr_card.dart';
import 'package:flutter/material.dart';

class DrCarousel extends StatelessWidget {
  const DrCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85,
      ),
      items: doctors.map((doctor) {
        return DoctorCard(
          name: doctor['name'],
          specialty: doctor['specialty'],
          imageUrl: doctor['imageUrl'],
          rating: doctor['rating'],
          backgroundImageUrl:
              'https://media.istockphoto.com/id/1387688781/vector/modern-layer-blue-colorful-abstract-design-background.jpg?s=612x612&w=0&k=20&c=wAKGTuxGlV3ZUAMVKXUpA_Lai89TZkYa059ubw5s-8U=',
        );
      }).toList(),
    );
  }
}
