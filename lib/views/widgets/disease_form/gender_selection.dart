import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final ValueNotifier<String> genderNotifier;

  const GenderSelector({
    Key? key,
    required this.genderNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: genderNotifier,
      builder: (context, currentGender, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: ['Male', 'Female', 'Other']
                .map((gender) => Expanded(
                      child: GestureDetector(
                        onTap: () => genderNotifier.value = gender,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: currentGender == gender
                                ? const Color(0xFF4A78FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              gender,
                              style: TextStyle(
                                color: currentGender == gender
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
