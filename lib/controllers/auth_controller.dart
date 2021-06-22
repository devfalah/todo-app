import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/services/user_service.dart';
import 'package:todo/views/home_view.dart';
import 'package:todo/views/login_view.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final googleUser = GoogleSignIn(scopes: ['email']);
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString name = ''.obs;

  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  Rxn<User> _user = Rxn<User>();
  User get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  Future<void> createUserWithEmailAndPassword() async {
    print(email.value);
    print(password.value);
    _auth
        .createUserWithEmailAndPassword(
      email: email.value,
      password: password.value,
    )
        .then((value) {
      saveUser(value);
    });
  }

  Future<void> signInWithEmailAndPassword() async {
    _auth.signInWithEmailAndPassword(
      email: email.value,
      password: password.value,
    );
  }

  void saveUser(UserCredential value) {
    UserService().addUserToFirestor(
      name: value.user.displayName ?? name.value,
      email: value.user.email,
      id: value.user.uid,
      photoUrl: value.user.photoURL,
    );
    Get.offAll(HomeView());
  }

  googleSignIn() async {
    final GoogleSignInAccount user = await googleUser.signIn();
    final GoogleSignInAuthentication googleAuth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      saveUser(value);
    });
  }

  signOut() async {
    await _auth.signOut();
    if (googleUser != null) {
      await googleUser.disconnect();
      await googleUser.signOut();
    }

    Get.offAll(() => LoginView());
  }
}
