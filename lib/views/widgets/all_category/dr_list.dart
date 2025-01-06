import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cure_connect_service/views/widgets/all_category/dr_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget buildDoctorsList(RxString selectedCategory) {
  return Obx(() => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .where('isAccepted', isEqualTo: true)
            .where('category',
                isEqualTo: selectedCategory.value == 'All'
                    ? null
                    : selectedCategory.value)
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
              return buildDoctorCard(doc);
            },
          );
        },
      ));
}
