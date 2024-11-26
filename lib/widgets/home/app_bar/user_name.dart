import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hi Faris!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          'Find your Doctor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
