import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/controllers/profile_controller.dart';
import 'package:todo/helper/constant.dart';
import 'widgets/text_form_field.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController profile = Get.find<ProfileController>();
  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    profile.onInit();
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: GetClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.greenAccent],
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, 1.0)),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Positioned(
            width: 350,
            left: 25,
            top: MediaQuery.of(context).size.height / 5,
            child: Obx(
              () => profile.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Form(
                      child: Column(
                        children: [
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(75.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 7.0,
                                )
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    profile.userModel.value.photoUrl ??
                                        placeholderImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          profile.editable.value
                              ? CustomTextFormField(
                                  controller: profile.textEditingController,
                                  labeText: "Name",
                                )
                              : Text(
                                  profile.userModel.value.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                  ),
                                ),
                          SizedBox(height: 15.0),
                          Text(
                            profile.userModel.value.email,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Container(
                            height: 30.0,
                            width: 95.0,
                            child: Material(
                              color: Colors.green,
                              shadowColor: Colors.greenAccent,
                              elevation: 7.0,
                              borderRadius: BorderRadius.circular(20.0),
                              child: GestureDetector(
                                onTap: () {
                                  profile.changeEditable();
                                },
                                child: Center(
                                  child: Text(
                                    profile.editable.value
                                        ? "Save Name"
                                        : "Edit name",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Container(
                            height: 30.0,
                            width: 95.0,
                            child: GestureDetector(
                              onTap: () {
                                auth.signOut();
                              },
                              child: Material(
                                color: Colors.red,
                                shadowColor: Colors.redAccent,
                                elevation: 7.0,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Center(
                                  child: Text(
                                    "Log out",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 350, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
