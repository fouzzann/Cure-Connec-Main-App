import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_filter/fee_range_list.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_filter/header_section.dart';
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
          HeaderSection(controller: controller),
          const SizedBox(height: 20),
          FeeRangeList(controller: controller),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

