import 'package:cure_connect_service/views/screens/booking_pages/book_appointment_date_and_time.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileView extends StatelessWidget {
  final Map<String, dynamic> data;

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
          onPressed: () => Get.back() 
        ),
        title: Text( 
          'Dr. ${data['fullName'] ?? 'Unknown Doctor'}', 
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(data['image'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['fullName'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data['category'] ?? 'Unknown Category',
                              style: const TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                text: '${data['hospitalName']} Hospital, ',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${data['location']}',
                                    style: const TextStyle(
                                      color: Color(0xFF4A78FF),  
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Stats Row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat(
                    icon: Icons.groups_outlined,
                    value: '5,000+',
                    label: 'Patients',
                    iconColor: Color(0xFF4A78FF), 
                  ),
                  _buildStat(
                    icon: Icons.workspace_premium_outlined,
                    value: "${data['yearsOfExperience']} Years",
                    label: 'Experience',
                    iconColor: Color(0xFF4A78FF), 
                  ),
                  _buildStat(
                    icon: Icons.star_outlined,
                    value: '4.8',
                    label: 'Rating',
                      iconColor: Color(0xFF4A78FF), 
                  ),
                  _buildStat(
                    icon: Icons.security_update_good,
                    value: 'Verified',
                    label: 'Profile',
                    iconColor: Color(0xFF4A78FF), 
                  ), 
                ],
              ),
            ),
            _buildSection(
              title: 'Working Time',
              content: '${data['availableDays']}',
            ),
            _buildSection(
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
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom( 
                    backgroundColor: Colors.blue[200],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), 
                    ),
                  ),
                  child: const Text('Send Message', 
                  style: TextStyle(color:Color(0xFF4A78FF),),), 
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(()=>AppointmentBookingDateAndTime(),
                    transition: Transition.rightToLeftWithFade); 
                  },
                  style: ElevatedButton.styleFrom( 
                    backgroundColor: const Color(0xFF4A78FF), 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),   
                    ),
                  ),
                  child: const Text('Book Appointment',
                  style: TextStyle(color: Colors.white),),  
                ), 
              ),
            ],
          ),
        ), 
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  } 
}
