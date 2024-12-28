import 'package:cure_connect_service/views/screens/search_dr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSearchBar extends StatelessWidget {
  const AppBarSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () {
        Get.to(() => SearchDr(), transition: Transition.downToUp);
      },
      child: Container(
        height: size.height * 0.055, // Responsive height
        width: size.width * 0.9, // Responsive width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.08),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: TextField(
            enabled: false,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Search....',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.width * 0.04, // Responsive font size
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.02,
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.grey.withOpacity(0.7),
                  size: size.width * 0.055,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ),
      ),
    );
  }
}