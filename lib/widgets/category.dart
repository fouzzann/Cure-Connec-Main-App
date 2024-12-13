import 'package:cure_connect_service/controllers/favorite_controller.dart';
import 'package:cure_connect_service/views/screens/booking_pages/dr_profile_view.dart';
import 'package:cure_connect_service/views/screens/search_dr.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final categories = [
    'All',
    'Addiction Medicine Specialist',
    'Allergist/Immunologist',
    'Anesthesiologist',
    'Cardiologist',
    'Chiropractor',
    'Clinical Pharmacologist',
    'Clinical Psychologist',   
    'Critical Care Specialist',
    'Dentist',
    'Dermatologist',
    'Emergency Medicine Specialist',
    'Endocrinologist',
    'ENT Specialist (Otolaryngologist)',
    'Family Medicine Physician',
    'Forensic Pathologist',
    'Gastroenterologist',
    'General Physician',
    'Geriatrician',
    'Gynecologist',
    'Hematologist',
    'Holistic Medicine Practitioner',
    'Hospitalist',
    'Hyperbaric Medicine Specialist',
    'Infectious Disease Specialist',
    'Integrative Medicine Specialist',
    'Maxillofacial Surgeon',
    'Medical Geneticist',
    'Neonatologist',
    'Nephrologist',
    'Neurologist',
    'Occupational Medicine Specialist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedic',
    'Pain Management Specialist',
    'Pathologist',
    'Pediatric Surgeon',
    'Pediatrician',
    'Physiotherapist',
    'Plastic Surgeon',
    'Podiatrist',
    'Pulmonologist',
    'Psychiatrist',
    'Radiologist',
    'Reproductive Endocrinologist',
    'Rheumatologist',
    'Sleep Medicine Specialist',
    'Sports Medicine Specialist',
    'Thoracic Surgeon',
    'Trauma Surgeon',
    'Transplant Surgeon',
    'Urologist',
    'Vascular Surgeon',
    'Veterinary Doctor'
  ];

  // Initialize the FavoritesController
  final FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    // Use a stateless approach with GetX reactivity
    final RxString selectedCategory = 'All'.obs;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildCategories(selectedCategory),
              const SizedBox(height: 20),
              Expanded(child: _buildDoctorsList(selectedCategory)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => Get.back(),
            ),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            Get.to(() => SearchDr(),
            transition: Transition.downToUp);
          },
        ),  
      ],
    );
  }

  Widget _buildCategories(RxString selectedCategory) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Obx(() => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => selectedCategory.value = category,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedCategory.value == category 
                      ? const Color(0xFF4A78FF) 
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selectedCategory.value == category
                        ? const Color(0xFF4A78FF)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: selectedCategory.value == category
                          ? Colors.white
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _buildDoctorsList(RxString selectedCategory) {
    return Obx(() => StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('isAccepted', isEqualTo: true)
          .where('category',
              isEqualTo: selectedCategory.value == 'All' ? null : selectedCategory.value)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xFF4A78FF),
          ));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return _buildDoctorCard(doc);
          },
        );
      },
    ));
  }

  Widget _buildDoctorCard(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Obx(() {
      final isFavorite = favoritesController.isFavorite(doc.id);

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      data['image'] ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['fullName'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ), 
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.blue : Colors.blue[400],
                              ),
                              onPressed: () => favoritesController.toggleFavorite(doc.id),
                            ),
                          ],
                        ),
                        Text(
                          '${data['category']} | ${data['hospitalName']} Hospital',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '${data['yearsOfExperience']} Years of experience',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${data['location']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '4.3',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(3,837 reviews)',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => DoctorProfileView(
                        data: data,
                      ),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A78FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}