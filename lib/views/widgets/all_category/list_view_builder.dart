import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget buildCategories(RxString selectedCategory) {
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