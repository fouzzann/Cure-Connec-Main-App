import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? id; 
  String name;
  String gender;
  int age;
  String disease;
  DateTime appointmentDate;
  String appointmentTime;
  double amount;
  DateTime createdAt;
  String drGmail;

  AppointmentModel({
    this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.disease,
    required this.appointmentDate,
    required this.appointmentTime,
    this.amount = 566.0,
    required this.drGmail,
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
      'amount': amount,
      'createdAt': createdAt,
      'drGmail':drGmail
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
      amount: map['amount'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      drGmail: map['drGmail']
    );
  }
}
