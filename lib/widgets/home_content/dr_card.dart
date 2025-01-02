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
    final screenWidth = MediaQuery.of(context).size.width;

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
          image: AssetImage('assets/Doctor Card Backgorund.png'),
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
                      children: _buildRatingStars(rating, starSize),
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

  List<Widget> _buildRatingStars(double rating, double starSize) {
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
}
