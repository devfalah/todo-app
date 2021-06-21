import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/services/user_service.dart';

class ProfileController extends GetxController {
  Rxn<UserModel> userModel = Rxn<UserModel>();

  RxBool isLoading = false.obs;
  RxBool editable = false.obs;
  RxString newName = ''.obs;
  var auth = FirebaseAuth.instance;

  @override
  void onInit() {
    String userId = Get.find<AuthController>().user.uid;
    userModel.bindStream(UserService().getUserFromFirestor(userId));

    super.onInit();
  }

  updateUser() {
    if (editable.value) {
      UserService().updateUserNameToFirestor(
          id: auth.currentUser.uid, name: newName.value);
    }
  }

  changeEditable() {
    updateUser();
    editable.value = !editable.value;
  }
}
