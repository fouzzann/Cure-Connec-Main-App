// lib/views/screens/search_dr/widgets/filter_button.dart

import 'package:flutter/material.dart';
import '../../../../utils/app_colors/app.theme.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasActiveFeeFilter;

  const FilterButton({
    super.key,
    required this.onPressed,
    required this.hasActiveFeeFilter,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        side: const BorderSide(color: AppColors.mainTheme, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'FILTER ₹',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.mainTheme,
            ),
          ),
          if (hasActiveFeeFilter)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.mainTheme,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 5,
                  minHeight: 5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}