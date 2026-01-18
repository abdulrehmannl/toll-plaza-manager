import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/repos/AuthRepo.dart';

class LoginVM extends GetxController {
  final AuthRepo authRepo = Get.put(AuthRepo());

  var isLoading = false.obs;

  // GLOBAL STATE
  var userId = "".obs;
  var laneNumber = "".obs;
  var userRole = "operator".obs;

  @override
  void onReady() {
    super.onReady();
    // Auto-login check
    User? currentUser = authRepo.getCurrentUser();
    if (currentUser != null) {
      loadUserDetails(currentUser.uid);
      checkAndRedirect(currentUser.email ?? "");
    }
  }

  Future<void> loadUserDetails(String uid) async {
    userId.value = uid;
    Map<String, dynamic>? details = await authRepo.fetchUserDetails(uid);

    if (details != null) {
      // Handles both 'lane' (new) and 'laneId' (old)
      laneNumber.value = details['lane'] ?? details['laneId'] ?? "L1";
      userRole.value = details['role'] ?? "operator";
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      var userCredentials = await authRepo.login(email.trim(), password.trim());
      String uid = userCredentials.user!.uid;

      await loadUserDetails(uid);
      checkAndRedirect(email);
      Get.snackbar("Success", "Welcome back!");
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void checkAndRedirect(String email) {
    if (email == "admin@toll.com" || userRole.value == 'admin') {
      Get.offAllNamed('/admin');
    } else {
      Get.offAllNamed('/home');
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    userId.value = "";
    Get.offAllNamed("/login");
  }

  // --- MISSING FUNCTIONS RESTORED BELOW ---

  bool isAlreadyLoggedIn() {
    return authRepo.getCurrentUser() != null;
  }

  bool isEmailVerified() {
    User? user = authRepo.getCurrentUser();
    return user != null && user.emailVerified;
  }
}
