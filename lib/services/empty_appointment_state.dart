import 'package:cure_connect_service/views/screens/all_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyAppointmentState extends StatelessWidget {
  final VoidCallback? onBookAppointment;

  const EmptyAppointmentState({
    Key? key,
    this.onBookAppointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                size: 48,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Appointments Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'You don\'t have any upcoming appointments scheduled. Book an appointment with a doctor to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(  
                onPressed: (){
                  Get.to(()=> AllCategoryPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF4A78FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}