import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? id; 
  String name;
  String gender;
  int age;
  String disease;
  DateTime appointmentDate;
  String appointmentTime;
  DateTime createdAt;
  String drEmail;
  String userEmail;
  String status;
  AppointmentModel({
    this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.disease,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.drEmail,
    required this.userEmail,
    required this.status,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'disease': disease,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'createdAt': createdAt,
      'drGmail':drEmail,
      'userEmail':userEmail,
      'status' : status
    };
  }

  factory AppointmentModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return AppointmentModel(
      id: documentId,
      name: map['name'],
      gender: map['gender'],
      age: map['age'],
      disease: map['disease'],
      appointmentDate: (map['appointmentDate'] as Timestamp).toDate(),
      appointmentTime: map['appointmentTime'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      drEmail: map['drGmail'],
      userEmail :map['userEmail'] ,
      status: map['status']
    );
  }
}
