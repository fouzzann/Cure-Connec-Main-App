import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';

class FeeRangeItem extends StatelessWidget {
  const FeeRangeItem({
    Key? key,
    required this.range,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final Map<String, dynamic> range;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainTheme.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? AppColors.mainTheme : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainTheme : Colors.white,
                border: Border.all(
                  color: isSelected ? AppColors.mainTheme : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    range['max'] == double.infinity
                        ? '₹${range['min']}+'
                        : '₹${range['min']} - ₹${range['max']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.mainTheme : Colors.black87,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Selected Range',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mainTheme.withOpacity(0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.mainTheme,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
