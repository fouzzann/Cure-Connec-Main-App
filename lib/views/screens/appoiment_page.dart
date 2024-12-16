import 'package:cure_connect_service/controllers/appointment_controller.dart';
import 'package:cure_connect_service/model/user_appointment_history_model.dart';
import 'package:cure_connect_service/services/empty_appointment_state.dart';
import 'package:cure_connect_service/widgets/booked_appointment/dr_image.dart';
import 'package:cure_connect_service/widgets/booked_appointment/icons_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  // MARK: - Properties
  final AppointmentController _appointmentController = Get.put(AppointmentController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // MARK: - Constants
  static const double _kPadding = 20.0;
  static const double _kBorderRadius = 24.0;


  // MARK: - Lifecycle Methods
  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  // MARK: - Private Methods
  Future<void> _fetchAppointments() async {
    await Future.delayed(Duration.zero, () {
      _appointmentController.getUserAppointmentHistory(_auth.currentUser!.email.toString());
    });
  }

  // MARK: - UI Components




  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildCancelButton(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMessageButton(),
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMessageButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        'Message',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(UserAppointmentHistoryModel doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: _kPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: _kPadding,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(_kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorInfo(doctor),
            const SizedBox(height: _kPadding),
            _buildAppointmentInfo(doctor),
            const SizedBox(height: _kPadding),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo(UserAppointmentHistoryModel doctor) {
    return Row(
      children: [
        buildDoctorImage(doctor.doctorModel.image),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.doctorModel.fullName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.doctorModel.category,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo(UserAppointmentHistoryModel doctor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          buildInfoColumn(
            Icons.access_time_rounded,
            'Time',
            doctor.appointmentModel.appointmentTime,
          ),
          const SizedBox(width: 24),
          buildInfoColumn(
            Icons.calendar_today_rounded,
            'Date',
            doctor.appointmentModel.appointmentTime,
          ),
          const SizedBox(width: 24),
          buildInfoColumn(
            Icons.star_rounded,
            'Rating',
            '3.3',
          ),
        ],
      ),
    );
  }

  // MARK: - Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
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
            return _buildAppointmentCard(_appointmentController.history[index]);
          },
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'My Appointments',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}