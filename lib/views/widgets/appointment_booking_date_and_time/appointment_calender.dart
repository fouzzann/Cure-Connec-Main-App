// lib/features/appointment/widgets/appointment_calendar.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime today;
  final Function(DateTime) onDateSelected;

  const AppointmentCalendar({
    Key? key,
    required this.selectedDate,
    required this.today,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A78FF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: 16),
          _buildWeekDays(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4A78FF).withOpacity(0.1),
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
    );
  }

  Widget _buildWeekDays() {
    return Row(
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
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 31,
      itemBuilder: (context, index) {
        return _buildCalendarDay(index);
      },
    );
  }

  Widget _buildCalendarDay(int index) {
    final currentDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      index + 1,
    );

    final isToday = currentDate.year == today.year &&
        currentDate.month == today.month &&
        currentDate.day == today.day;

    final isSelected = currentDate.year == selectedDate.year &&
        currentDate.month == selectedDate.month &&
        currentDate.day == selectedDate.day;

    final isPastDate = currentDate.isBefore(DateTime(
      today.year,
      today.month,
      today.day,
    ));

    return InkWell(
      onTap: isPastDate ? null : () => onDateSelected(currentDate),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? const Color(0xFF4A78FF)
              : isToday
                  ? const Color(0xFF4A78FF).withOpacity(0.1)
                  : null,
          border: isToday && !isSelected
              ? Border.all(color: const Color(0xFF4A78FF), width: 1)
              : null,
        ),
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : isToday
                    ? const Color(0xFF4A78FF)
                    : isPastDate
                        ? Colors.grey
                        : Colors.black,
            fontWeight:
                isSelected || isToday ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}