import 'package:cure_connect_service/model/appointment_model.dart';
import 'package:cure_connect_service/model/doctor_model.dart';

class UserAppointmentHistoryModel {
  final AppointmentModel appointmentModel ;
  final Doctor doctorModel;

  UserAppointmentHistoryModel({required this.appointmentModel, required this.doctorModel});
}