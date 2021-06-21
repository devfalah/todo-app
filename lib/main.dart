import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/helper/binding.dart';
import 'package:todo/views/home_view.dart';

import 'package:todo/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Bind(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ControllerView(),
    );
  }
}

class ControllerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Get.find<AuthController>().user != null ? HomeView() : LoginView());
  }
}
