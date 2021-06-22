import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/views/register_view.dart';
import 'widgets/text_form_field.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  Animation animation, delayAnimation, muchDelayAnimation;
  AnimationController animationController;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final AuthController auth = Get.find();

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    delayAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    muchDelayAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    loginFormKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                animation.value * widthDevice,
                0.0,
                0.0,
              ),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                      child: Text(
                        "Hello",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 155.0, 0.0, 0.0),
                      child: Text(
                        "There",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(250.0, 155.0, 0.0, 0.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 80.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                delayAnimation.value * widthDevice,
                0,
                0,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labeText: "EMAIL",
                        onSave: (value) {
                          auth.email.value = value;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labeText: "PASSWORD",
                        obscureText: true,
                        onSave: (value) {
                          auth.password.value = value;
                        },
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.greenAccent],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                          ),
                        ),
                        child: GestureDetector(
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            loginFormKey.currentState.save();
                            auth.signInWithEmailAndPassword();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.0),
                              GestureDetector(
                                child: Text(
                                  "Log in with Google",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  auth.googleSignIn();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35.0),
                      Transform(
                        transform: Matrix4.translationValues(
                          muchDelayAnimation.value * widthDevice,
                          0,
                          0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New to spotify ?",
                              style: TextStyle(),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                Get.to(() => RegisterView());
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
