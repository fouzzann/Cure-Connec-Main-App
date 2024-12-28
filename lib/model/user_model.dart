class UserModel {
  final String name;
  final String image;
  final String uid;
  final String email;

  UserModel(
      {required this.name,
      required this.image,
      required this.uid,
      required this.email});
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        image: map['image'],
        uid: map['uid'],
        email: map['email']);
  }

  toMap() {
    return {'name': name, 'image': image, 'uid': uid, 'email': email};
  }
}
