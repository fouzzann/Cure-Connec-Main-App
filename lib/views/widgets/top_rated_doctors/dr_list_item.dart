import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DoctorListItem extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorListItem({
    required this.doctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorImage(),
              SizedBox(width: 16),
              Expanded(
                child: _buildDoctorInfo(),
              ),
              _buildNavigationButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorImage() {
    return Hero(
      tag: 'doctor-${doctor['fullName']}',
      child: Container(
        width: 90,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
              doctor['image'] ?? 'https://via.placeholder.com/90'
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingBadge(),
        SizedBox(height: 8),
        Text(
          'Dr. ${doctor['fullName'] ?? 'Unknown'}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          doctor['category'] ?? 'Specialist',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        _buildLocation(),
      ],
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.mainTheme.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: AppColors.mainTheme,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(
            doctor['rating'] ?? '0.0',
            style: TextStyle(
              color: AppColors.mainTheme,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.grey[400],
          size: 16,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            doctor['location'] ?? 'Unknown Location',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mainTheme,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => DoctorProfileView(data: doctor),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}