import 'package:cure_connect_service/views/screens/booking_pages/book_appointment_date_and_time.dart.dart';
import 'package:cure_connect_service/views/widgets/dr_profile_view/profile_header.dart';
import 'package:cure_connect_service/views/widgets/dr_profile_view/profile_section.dart';
import 'package:cure_connect_service/views/widgets/dr_profile_view/stat_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileView extends StatelessWidget {
  final data;

  const DoctorProfileView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Get.back()),
        title: Text(
          'Dr. ${data['fullName'] ?? 'Unknown Doctor'}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(data: data),
            StatRow(data: data),
            ProfileSection(
              title: "Working Day's",
              content: '${data['availableDays']}',
            ),
            ProfileSection(
              title: 'Consultation Fee', 
              content: 'Rs:${data['consultationFee']}',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                        () => AppointmentBookingDateAndTime(
                              drEmail: data['email'],
                              fee: data['consultationFee'],
                            ),
                        transition: Transition.rightToLeftWithFade);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A78FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
