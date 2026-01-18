import 'package:get/get.dart';

import '../../../data/repos/AuthRepo.dart';

class ForgotPasswordVM extends GetxController {
  AuthRepo authRepo = Get.find();

  // reset password function
  Future<void> reset(String email) async {
    try {
      await authRepo.resetPassword(email);
      Get.snackbar("Email Sent", "Check your inbox to reset password");
    } catch (e) {
      Get.snackbar("Failed", e.toString());
    }
  }
}
