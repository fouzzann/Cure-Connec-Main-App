import 'package:flutter/material.dart';
import 'package:cure_connect_service/utils/app_colors/app.theme.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const SearchContainer({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.mainTheme,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SearchBar(
          backgroundColor:  WidgetStatePropertyAll(Colors.white),
          leading: const Icon(Icons.search, color: Colors.grey),
          hintText: 'Search....',
          controller: searchController,
          onChanged: onSearchChanged,
        ),
      ),
    );
  }
}