class Appointment {
  final String gender;
  final String fullName;
  final String age;
  final String userDisease;
  final String image;
  final String date;
  final String time;
  Appointment(
      {required this.gender,
      required this.fullName,
      required this.age,
      required this.userDisease,
      required this.image,
      required this.date,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'time': time,
      'date': date
    };
  }
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
        image: map['image'] ?? '',
        fullName: map['fullName'] ?? '',
        age: map['age'] ?? '',
        gender: map['gender'] ?? '',
        userDisease: map['userDisease'],
        date: map['date'],
        time: map['time']);
  }
}
