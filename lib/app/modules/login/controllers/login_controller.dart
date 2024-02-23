import 'package:get/get.dart';

class LoginController extends GetxController {
  var passwordVisible = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.toggle();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
