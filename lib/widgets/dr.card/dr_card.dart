import 'package:flutter/material.dart';

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
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Define responsive values based on screen width
    final double containerMargin = screenWidth < 600 ? 5.0 : 10.0;
    final double containerPadding = screenWidth < 600 ? 15.0 : 20.0;
    final double nameSize = screenWidth < 600 ? 20.0 : 24.0;
    final double specialtySize = screenWidth < 600 ? 14.0 : 16.0;
    final double starSize = screenWidth < 60 ? 16.0 : 20.0;
    final double avatarRadius = screenWidth < 600 ? 20.0 : 25.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: containerMargin),
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
          image: NetworkImage('https://media.istockphoto.com/id/1387688781/vector/modern-layer-blue-colorful-abstract-design-background.jpg?s=612x612&w=0&k=20&c=wAKGTuxGlV3ZUAMVKXUpA_Lai89TZkYa059ubw5s-8U='),
          fit: BoxFit.cover,
        ),
      ),
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
            padding: EdgeInsets.all(containerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: starSize,
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
          ),
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