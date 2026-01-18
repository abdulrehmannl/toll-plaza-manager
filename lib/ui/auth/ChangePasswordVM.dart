import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/repos/AuthRepo.dart';

class ChangePasswordVM extends GetxController {
  var isLoading = false.obs;

  final authRepo = Get.find<AuthRepo>();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      isLoading.value = true;

      // We MUST reauthenticate user before password update
      // (Firebase rule)
      var user = authRepo.getCurrentUser();

      var cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(cred);

      // Now update password
      await authRepo.changePassword(newPassword);

      Get.snackbar("Success", "Password changed successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
