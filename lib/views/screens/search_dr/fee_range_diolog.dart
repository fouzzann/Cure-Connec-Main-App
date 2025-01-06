import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeeRangeDialog extends StatelessWidget {
  final SearchDrController controller = Get.find<SearchDrController>();

  FeeRangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Fee Range',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.clearFeeFilter();
                  Get.back();
                },
                icon: const Icon(Icons.refresh, color: AppColors.mainTheme),
                tooltip: 'Reset Filter',
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(
            controller.feeRanges.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Obx(() {
                final range = controller.feeRanges[index];
                final isSelected = range['isSelected'];
                return InkWell(
                  onTap: () {
                    controller.toggleFeeRange(index);
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.mainTheme.withOpacity(0.1)
                          : Colors.grey[100],
                      border: Border.all(
                        color: isSelected
                            ? AppColors.mainTheme
                            : Colors.transparent,
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
                            color: isSelected
                                ? AppColors.mainTheme
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mainTheme
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
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
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? AppColors.mainTheme
                                      : Colors.black87,
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
              }),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}