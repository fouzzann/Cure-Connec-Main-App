import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/views/widgets/appointment_booking_date_and_time/appointment_app_bar_widget.dart';
import 'package:cure_connect_service/views/widgets/appointment_booking_date_and_time/appointment_calender.dart';
import 'package:cure_connect_service/views/widgets/appointment_booking_date_and_time/appointment_next_button.dart';
import 'package:cure_connect_service/views/widgets/appointment_booking_date_and_time/time_slot_grid_widger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentBookingDateAndTime extends StatefulWidget {
  const AppointmentBookingDateAndTime(
      {Key? key, required this.drEmail, required this.fee})
      : super(key: key);

  final String drEmail;
  final String fee;

  @override
  State<AppointmentBookingDateAndTime> createState() =>
      _AppointmentBookingDateAndTimeState();
}

class _AppointmentBookingDateAndTimeState
    extends State<AppointmentBookingDateAndTime> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  final DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  String? selectedTime;
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  void onTimeSelected(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppointmentAppBar(title: 'Select Date and Time'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            AppointmentCalendar(
              selectedDate: selectedDate,
              today: today,
              onDateSelected: onDateSelected,
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TimeSlotsGrid(
              selectedTime: selectedTime,
              onTimeSelected: onTimeSelected,
            ),
            const SizedBox(height: 32),
            AppointmentNextButton(
              selectedTime: selectedTime,
              selectedDate: selectedDate,
              drEmail: widget.drEmail,
              fee: widget.fee,
              appointmentController: appointmentController,
            ),
          ],
        ),
      ),
    );
  }
}
