import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/services/user_service.dart';

class ProfileController extends GetxController {
  Rxn<UserModel> userModel = Rxn<UserModel>();

  RxBool isLoading = false.obs;
  RxBool editable = false.obs;
  TextEditingController textEditingController = TextEditingController();
  RxString userId = ''.obs;

  @override
  void onInit() {
 
    userId.value = Get.find<AuthController>().user.uid;

    userModel.bindStream(UserService().getUserFromFirestor(userId.value));

    super.onInit();
  }

 

  updateUser() {
    if (editable.value) {
      UserService().updateUserNameToFirestor(
          id: userId.value, name: textEditingController.text);
    }
  }

  changeEditable() {
    updateUser();
    editable.value = !editable.value;
  }
}
