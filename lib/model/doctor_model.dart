class Doctor {
  final String image;
  final String fullName;
  final String age;
  final String email;
  final String gender;
  final String uid;
  final String category;
  final String hospitalName;
  final String location;
  final bool isAccepted;
  final String? docId;
  final String consultationFee;
  final String yearsOfExperience;
  final String certificateImage;
  final List<String> availableDays;

  Doctor({
    required this.image,
    required this.fullName,
    required this.age,
    required this.email, 
    required this.gender,
    required this.uid,
    required this.category,
    required this.hospitalName,
    required this.location,
    required this.isAccepted,
    this.docId,
    required this.consultationFee,
    required this.yearsOfExperience,
    required this.certificateImage,
    required this.availableDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'fullName': fullName,
      'age': age,
      'email': email,
      'gender': gender,
      'uid': uid,
      'category': category,
      'hospitalName': hospitalName,
      'location': location,
      'isAccepted': isAccepted,
      'docId': docId,
      'consultationFee': consultationFee,
      'yearsOfExperience': yearsOfExperience,
      'certificateImage': certificateImage,
      'availableDays': availableDays,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      image: map['image'] ?? '',
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      uid: map['uid'] ?? '',
      category: map['category'] ?? '',
      hospitalName: map['hospitalName'] ?? '',
      location: map['location'] ?? '',
      isAccepted: map['isAccepted'] ?? false,
      docId: map['docId'],
      consultationFee: map['consultationFee'] ?? '',
      yearsOfExperience: map['yearsOfExperience'] ?? '',
      certificateImage: map['certificateImage'] ?? '',
      availableDays: List<String>.from(map['availableDays'] ?? []),
    );
  }
}
