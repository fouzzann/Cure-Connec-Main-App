import 'package:cure_connect_service/controllers/search_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:cure_connect_service/views/utils/app_colors/app.theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewBuilder extends StatelessWidget {
   ListViewBuilder({super.key});

  @override
  final SearchDrController controller = Get.put(SearchDrController());
  Widget build(BuildContext context) {
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
              backgroundColor: AppColors.drSearchBar,
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
                        color: AppColors.mainTheme,
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
                backgroundColor: AppColors.mainTheme
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