import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RatingController extends GetxController {
  final RxSet<String> ratedAppointments = <String>{}.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void markAsRated(String appointmentId) {
    ratedAppointments.add(appointmentId);
  }
 
  bool isRated(String appointmentId) {
    return ratedAppointments.contains(appointmentId);
  }

  Future<void> initializeRatingStatus(String appointmentId) async {
    if (!isRated(appointmentId)) {
      final QuerySnapshot ratingDoc = await _firestore
          .collection('ratings')
          .where('appointmentId', isEqualTo: appointmentId)
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .get();

      if (ratingDoc.docs.isNotEmpty) {
        markAsRated(appointmentId);
      }
    }
  }

  void checkRatingStatus(String appointmentId) {}
}