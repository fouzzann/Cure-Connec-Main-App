import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchDr extends StatefulWidget {
  const SearchDr({Key? key}) : super(key: key);

  @override
  State<SearchDr> createState() => _SearchDrState();
}

class _SearchDrState extends State<SearchDr> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _users = [];
  List<String> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categoriesSnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      setState(() {
        _categories = categoriesSnapshot.docs
            .map((doc) => doc['name'] as String)
            .toList();
      });
    } catch (e) {
      _showErrorSnackbar('Error loading categories');
    }
  }

  void _searchUsers(String query) async {
    if (query.isEmpty && _selectedCategory == null) {
      setState(() {
        _users = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Query doctorsQuery = FirebaseFirestore.instance.collection('doctors');

      // Apply category filter if selected
      if (_selectedCategory != null) {
        doctorsQuery =
            doctorsQuery.where('category', isEqualTo: _selectedCategory);
      }

      // Apply name search if query exists
      if (query.isNotEmpty) {
        String capitalizedQuery =
            query[0].toUpperCase() + query.substring(1).toLowerCase();
        doctorsQuery = doctorsQuery
            .where('fullName', isGreaterThanOrEqualTo: capitalizedQuery)
            .where('fullName', isLessThan: capitalizedQuery + '\uf8ff');
      }

      final userQuery = await doctorsQuery.get();

      setState(() {
        _users = userQuery.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Error searching users');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 40),
        ),
        title: const Text(
          'Search Doctors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Category Filter
          if (_categories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategory,
                    hint: const Text('Select Category'),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('All Categories'),
                      ),
                      ..._categories
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                      _searchUsers(_searchController.text);
                    },
                  ),
                ),
              ),
            ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchUsers('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: _searchUsers,
            ),
          ),

          // Search Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF4A78FF)),
      );
    }

    if (_users.isEmpty &&
        (_searchController.text.isNotEmpty || _selectedCategory != null)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No doctors found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Search Doctors by Name or Category',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index].data() as Map<String, dynamic>;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  user['image'] != null ? NetworkImage(user['image']) : null,
              backgroundColor: Colors.grey[200],
              child: user['image'] == null 
                  ? Icon(Icons.person, color: Colors.grey[600])
                  : null,
            ),
            title: Text(
              user['fullName'] ?? user['username'] ?? 'Unknown User',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user['category'] != null)
                  Text(user['category'],
                      style: const TextStyle(
                        color: Color(0xFF4A78FF),
                        fontWeight: FontWeight.w500,
                      )),
                if (user['username'] != null) Text('@${user['username']}'),
                if (user['bio'] != null)
                  Text(user['bio'],
                      maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Get.to(() => DoctorProfileView(data: _users[index].data()),
                    transition: Transition.rightToLeftWithFade);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A78FF),
              ),
              child: const Text(
                'Connect',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
