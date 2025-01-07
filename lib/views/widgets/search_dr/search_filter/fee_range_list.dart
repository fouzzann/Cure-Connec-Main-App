import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/widgets/search_dr/search_filter/fee_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeeRangeList extends StatelessWidget {
  const FeeRangeList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SearchDrController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controller.feeRanges.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Obx(() {
            final range = controller.feeRanges[index];
            final isSelected = range['isSelected'];
            return FeeRangeItem(
              range: range,
              isSelected: isSelected,
              onTap: () {
                controller.toggleFeeRange(index);
                Get.back();
              },
            );
          }),
        ),
      ),
    );
  }
}
