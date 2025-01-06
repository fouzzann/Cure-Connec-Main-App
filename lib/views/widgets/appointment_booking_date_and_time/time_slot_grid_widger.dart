// lib/features/appointment/widgets/time_slots_grid.dart

import 'package:flutter/material.dart';

class TimeSlotsGrid extends StatelessWidget {
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const TimeSlotsGrid({
    Key? key,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  static const List<String> timeSlots = [
    '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM',
    '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
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
          onTap: () => onTimeSelected(timeSlot),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4A78FF)),
              borderRadius: BorderRadius.circular(25),
              color: isSelected ? const Color(0xFF4A78FF) : Colors.transparent,
            ),
            alignment: Alignment.center,
            child: Text(
              timeSlot,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF4A78FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}