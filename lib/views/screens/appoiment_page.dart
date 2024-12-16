import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/services/empty_appointment_state.dart';
import 'package:cure_connect_service/widgets/booked_appointment/app_bar_title.dart';
import 'package:cure_connect_service/widgets/booked_appointment/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final AppointmentController _appointmentController =
      Get.put(AppointmentController());

  static const double _kPadding = 20.0;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: buildAppBar(),
      body: Obx(() {
        if (_appointmentController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (_appointmentController.history.isEmpty) {
          return EmptyAppointmentState(onBookAppointment: () {});
        }

        return ListView.builder(
          padding: const EdgeInsets.all(_kPadding),
          itemCount: _appointmentController.history.length,
          itemBuilder: (context, index) {
            return buildAppointmentCard(_appointmentController.history[index]);
          },
        );
      }),
    );
  }
}
