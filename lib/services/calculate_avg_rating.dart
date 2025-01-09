import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

calculateAvgRating(drEmail) async {
  try {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(drEmail)
        .get();
    final List<dynamic> dynamicList =
        documentSnapshot.data()?['ratingList'] as List<dynamic>;
    List<int> ratingList = dynamicList.map((e) => e as int).toList();
    int sum = 0;
    for (var element in ratingList) {
      sum += element;
    }
    double avg = sum / ratingList.length;
    return avg;
  } catch (e) {
    log('avg :$e');
    return 0.0;
  }
}
