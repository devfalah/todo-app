import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'widgets/text_form_field.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  Animation animation, delayAnimation, muchDelayAnimation;
  AnimationController animationController;

  final AuthController auth = Get.find();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    delayAnimation = Tween(begin: -1, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
    muchDelayAnimation = Tween(begin: -1, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    animationController.dispose();
    auth.regFormKey.currentState.dispose();
    print('111');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthDevice = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                animation.value * widthDevice,
                0,
                0,
              ),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 70.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(270.0, 105.0, 0.0, 0.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 70.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0),
              child: Transform(
                transform: Matrix4.translationValues(
                    delayAnimation.value * widthDevice, 0, 0),
                child: Form(
                  key: auth.regFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labeText: "NICK NAME",
                        onSave: (value) {
                          auth.name.value = value;
                        },
                      ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 40.0),
                      Transform(
                        transform: Matrix4.translationValues(
                            muchDelayAnimation.value * widthDevice, 0, 0),
                        child: Container(
                          height: 50.0,
                          child: GestureDetector(
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  "SIGNUP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              auth.regFormKey.currentState.save();
                              auth.createUserWithEmailAndPassword();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
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
                          child: Center(
                            child: Text(
                              "Go Back",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
