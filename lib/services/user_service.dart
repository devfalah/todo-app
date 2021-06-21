import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/user_model.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUserToFirestor(
      {String name, String email, String id, String photoUrl}) {
    return users
        .doc(id)
        .set({
          'email': email,
          'name': name,
          'id': id,
          'photoUrl': photoUrl,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUserNameToFirestor({String name, String id}) {
    return users
        .doc(id)
        .update({
          'name': name,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<UserModel> getUserFromFirestor(String id) {
    return users.doc(id).snapshots().map((event) {
      return UserModel.fromMap(event.data());
    });
  }
}
