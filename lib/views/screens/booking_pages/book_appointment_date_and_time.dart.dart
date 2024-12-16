import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'disease_form.dart'; // Import the disease form page

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
  DateTime selectedDate = DateTime.now();
  final DateTime today = DateTime.now();
  String? selectedTime;

  final List<String> timeSlots = [
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Date and Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            _buildCalendar(),
            const SizedBox(height: 24),
            const Text(
              'Select Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            _buildTimeSlots(),
            const SizedBox(height: 32),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4A78FF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF4A78FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Today: ${DateFormat('MMM d').format(today)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                .map((day) => Text(
                      day,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              final currentDate =
                  DateTime(selectedDate.year, selectedDate.month, index + 1);
              final isToday = currentDate.year == today.year &&
                  currentDate.month == today.month &&
                  currentDate.day == today.day;
              final isSelected = currentDate.year == selectedDate.year &&
                  currentDate.month == selectedDate.month &&
                  currentDate.day == selectedDate.day;

              final isPastDate = currentDate.isBefore(today);

              return InkWell(
                onTap: isPastDate
                    ? null
                    : () {
                        setState(() {
                          selectedDate = currentDate;
                        });
                      },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Color(0xFF4A78FF)
                        : isToday
                            ? Color(0xFF4A78FF).withOpacity(0.1)
                            : null,
                    border: isToday && !isSelected
                        ? Border.all(color: Color(0xFF4A78FF), width: 1)
                        : null,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isToday
                              ? Colors.blue
                              : Colors.black,
                      fontWeight: isSelected || isToday
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlots() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = timeSlots[index];
        final isSelected = selectedTime == timeSlot;

        return InkWell(
          onTap: () {
            setState(() {
              selectedTime = timeSlot;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF4A78FF)),
              borderRadius: BorderRadius.circular(25),
              color: isSelected ? Color(0xFF4A78FF) : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              timeSlot,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFF4A78FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedTime != null
            ? () {
                Get.to(
                    () => DiseaseForm(
                          selectedDate: selectedDate,
                          selectedTime: selectedTime!,
                          drEmail: widget.drEmail,
                          fee: widget.fee,
                        ),
                    transition: Transition.rightToLeftWithFade);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4A78FF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
