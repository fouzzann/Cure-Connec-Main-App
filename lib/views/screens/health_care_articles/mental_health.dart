import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MentalHealth extends StatelessWidget {
  const MentalHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Mental Health Awareness',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
         
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Mental Health Awareness: Understanding and Breaking the Stigma'),
              _buildContentText(
                'Mental health is a crucial aspect of our overall well-being, yet it is often overlooked or misunderstood. Many people fail to recognize its importance until they face challenges themselves.',
              ),
              const SizedBox(height: 16),
              
              _buildSectionTitle('What is Mental Health?'),
              _buildContentText(
                'Mental health refers to a person\'s emotional, psychological, and social well-being. It affects how we think, feel, and act. Mental health also influences how we handle stress, relate to others, and make choices.',
              ),
              const SizedBox(height: 16),
              
              _buildSectionTitle('Common Mental Health Disorders'),
              _buildDisorderSection('Anxiety Disorders', 
                'Anxiety is one of the most common mental health issues globally. It can manifest in different forms, such as generalized anxiety disorder, panic disorder, and social anxiety.'),
              _buildDisorderSection('Depression', 
                'Depression is a persistent feeling of sadness or hopelessness that affects a person\'s ability to function in daily life. It can lead to a lack of energy and difficulty concentrating.'),
              _buildDisorderSection('Bipolar Disorder', 
                'Bipolar disorder involves extreme mood swings that include periods of depression and episodes of mania or hypomania (elevated mood).'),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                title: 'Breaking the Stigma',
                content: 'Mental health stigma prevents people from seeking help. By understanding and supporting those with mental health challenges, we can create a more compassionate society.',
                color: Color(0xFF4A78FF).withOpacity(0.1),
              ),
              
              const SizedBox(height: 16),
              
              _buildSectionTitle('Why Mental Health Awareness Matters'),
              _buildBulletPoints([
                'Promotes Early Intervention',
                'Reduces Social Stigma',
                'Encourages Empathy and Support',
                'Creates Supportive Environments'
              ]),
              
              const SizedBox(height: 16),
              
              _buildSectionTitle('Steps to Promote Mental Health Awareness'),
              _buildBulletPoints([
                'Engage in Education and Training',
                'Encourage Open Conversations',
                'Support Mental Health Initiatives',
                'Check-In with Loved Ones',
                'Practice and Promote Self-Care'
              ]),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                title: 'Final Thought',
                content: 'Mental health is just as important as physical health. By promoting awareness, we contribute to a more inclusive, empathetic, and healthier society.',
                color: Color(0xFF4A78FF).withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A78FF),
        ),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }

  Widget _buildDisorderSection(String disorder, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            disorder,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A78FF),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF4A78FF), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF4A78FF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A78FF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}