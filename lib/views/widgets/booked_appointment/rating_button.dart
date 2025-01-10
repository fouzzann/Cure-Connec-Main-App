import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/appointment_card.dart';
import 'package:cure_connect_service/views/widgets/booked_appointment/show_diolog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AppointmentRatingButton extends StatefulWidget {
  final String appointmentId;
  final String doctorId;
  final String doctorEmail;
  final AppointmentController appointmentController;

  const AppointmentRatingButton({
    Key? key,
    required this.appointmentId,
    required this.doctorId,
    required this.doctorEmail,
    required this.appointmentController,
  }) : super(key: key);

  @override
  State<AppointmentRatingButton> createState() =>
      _AppointmentRatingButtonState();
}

class _AppointmentRatingButtonState extends State<AppointmentRatingButton> {
  late Future<void> _initializeFuture;

  @override
  void initState() {
    super.initState();
    _initializeFuture =
        ratingController.initializeRatingStatus(widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }

        return Obx(() => ratingController.isRated(widget.appointmentId)
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Already Rated'), 
                    action: SnackBarAction( 
                        label: 'clear',
                         textColor: Colors.white, 
                        onPressed: () {
                          Get.back();
                        }),
                  ));
                },
                child: Row(
                  children: [
                    const Text(
                      'Rated',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 15,
                    )
                  ],
                ),
              )
            : buildRatingButton(widget.doctorId, widget.appointmentId,
                widget.doctorEmail, widget.appointmentController));
      },
    );
  }
}

Widget buildRatingButton(String doctorId, String appointmentId,
    String doctorEmail, AppointmentController appointmentController) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A78FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      showRatingDialog(
          doctorId, appointmentId, doctorEmail, appointmentController);
    },
    child: Row(
      children: [
        const Text(
          'Rate',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.star,
          color: Colors.white,
          size: 15,
        )
      ],
    ),
  );
}
