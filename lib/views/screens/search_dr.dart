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
  List<DocumentSnapshot> _doctors = [];
  bool _isLoading = false;

  void _searchDoctors(String query) async {
    if (query.isEmpty) {
      setState(() {
        _doctors = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Convert the query to lowercase for case-insensitive search
      final normalizedQuery = query.toLowerCase();

      // Query to search by full name (case-insensitive)
      final nameQuery = await FirebaseFirestore.instance
          .collection('doctors')
          .where('fullName', isGreaterThanOrEqualTo: normalizedQuery)
          .where('fullName', isLessThan: normalizedQuery) 
          .get();

      setState(() {
        _doctors = nameQuery.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Error searching doctors');
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
                          setState(() {
                            _doctors = [];
                          });
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
              onChanged: _searchDoctors,
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
    // Loading State
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color:  Color(0xFF4A78FF),), 
      );
    }

    // No Results State
    if (_doctors.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
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

    // Initial State
    if (_doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Search for doctors',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // Results List
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index].data() as Map<String, dynamic>;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: doctor['image'] != null
                  ? NetworkImage(doctor['image'])
                  : null,
              backgroundColor: Colors.grey[200],
              child: doctor['image'] == null
                  ? Icon(Icons.person, color: Colors.grey[600])
                  : null,
            ),
            title: Text(
              doctor['fullName'] ?? 'Unknown Doctor',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor['category'] ?? 'Unknown Specialty'),
                Text(doctor['hospitalName'] ?? 'Unknown Hospital'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Connect', 
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A78FF),
              ),
            ),
          ),
        );
      },
    );
  }
} 
