
import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDr extends StatelessWidget {
  final SearchDrController controller = Get.put(SearchDrController());

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
          Obx(() => _buildCategoryFilter()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchUsers('');
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
              onChanged: controller.searchUsers,
            ),
          ),
          Expanded(child: Obx(() => _buildSearchResults())),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    if (controller.categories.isEmpty) {
      return const SizedBox();
    }  

    return Padding(
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
            value: controller.selectedCategory.value,
            hint: const Text('Select Category'),
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Categories'),
              ), 
              ...controller.categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
            ],
            onChanged: (value) {
              controller.selectedCategory.value = value;
              controller.searchUsers(controller.searchController.text);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF4A78FF)),
      );
    }

    if (controller.users.isEmpty &&
        (controller.searchController.text.isNotEmpty ||
            controller.selectedCategory.value != null)) {
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

    if (controller.users.isEmpty) {
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
      itemCount: controller.users.length,
      itemBuilder: (context, index) {
        final user =
            controller.users[index].data() as Map<String, dynamic>;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: user['image'] != null
                  ? NetworkImage(user['image'])
                  : null,
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
                Get.to(() => DoctorProfileView(data: controller.users[index].data()),
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
