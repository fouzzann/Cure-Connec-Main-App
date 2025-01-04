import 'package:flutter/material.dart';

class GrindOverlay extends StatelessWidget {
  const GrindOverlay({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4A78FF).withOpacity(0.2),
            const Color(0xFF4A78FF).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
