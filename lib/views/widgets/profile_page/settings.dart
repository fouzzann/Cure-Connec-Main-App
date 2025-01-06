import 'package:cure_connect_service/views/screens/profile%20page/favorite_page.dart';
import 'package:cure_connect_service/views/screens/profile%20page/privecy_and_policy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => PrivacyPolicyPage());
          },
          child: _buildSettingsItem(
            icon: Icons.shield_outlined,
            title: 'Privacy and Policy',
            subtitle: '2FA, Privacy',
            iconBgColor: Colors.green.withOpacity(0.1),
            iconColor: Colors.green,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => FavoritePage(),
                transition: Transition.rightToLeftWithFade);
          },
          child: _buildSettingsItem(
            icon: Icons.favorite_rounded,
            title: 'Favorite',
            subtitle: 'Liked doctors',
            iconBgColor: Colors.purple.withOpacity(0.1),
            iconColor: Colors.purple,
          ),
        ),
        GestureDetector(
          onTap: () async {
            const email = 'fouzanp.official@gmail.com';
            const subject = 'Feedback for Your App';
            const body = 'Enter your feedback here..';

            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: email,
              queryParameters: {
                'subject': subject,
                'body': body,
              },
            );
            await launchUrl(emailLaunchUri);
          },
          child: _buildSettingsItem(
            icon: Icons.feedback_outlined,
            title: 'Send Feedback',
            subtitle: 'Help us improve our app',
            iconBgColor: Colors.orange.withOpacity(0.1),
            iconColor: Colors.orange,
          ),
        ),
      ],
    );
  }
}

Widget _buildSettingsItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color iconBgColor,
  required Color iconColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey[200]!,
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
        ),
      ],
    ),
  );
}
