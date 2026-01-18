import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repos/AuthRepo.dart';

class SignUpVM extends GetxController {
  // Safe injection
  final AuthRepo _authRepo = Get.put(AuthRepo());

  var isLoading = false.obs;

  // --- THIS IS THE MISSING METHOD ---
  Future<void> registerUser(String email, String password, String lane) async {
    isLoading.value = true;
    try {
      // 1. Call Repo to create account & save to Firestore
      await _authRepo.signup(email, password, lane);

      // 2. Success Feedback
      Get.snackbar(
        "Success",
        "Account created! Please verify your email.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // 3. Navigate back to Login
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
