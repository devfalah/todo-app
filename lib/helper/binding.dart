import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/controllers/profile_controller.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
