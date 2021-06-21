class UserModel {
  String name;
  String email;
  String photoUrl;
  String id;
  UserModel({
    this.name,
    this.email,
    this.photoUrl,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
