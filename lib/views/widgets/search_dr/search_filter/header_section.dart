import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SearchDrController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
