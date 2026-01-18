import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repos/TollRepo.dart';
import '../auth/LoginVM.dart';

class AddCarVM extends GetxController {
  // Dependencies
  final TollRepo tollRepo = Get.find<TollRepo>();
  final LoginVM loginVM = Get.find<LoginVM>();

  // State
  var isLoading = false.obs;
  var selectedType = "Car".obs;
  var autoAmount = 50.0.obs;

  // Configuration
  final Map<String, double> priceList = {
    "Bike": 20.0,
    "Car": 50.0,
    "Van": 80.0,
    "Bus": 150.0,
    "Truck": 200.0,
    "Emergency": 0.0,
  };

  // Logic: Update dropdown and auto-set price
  void updateType(String? newValue) {
    if (newValue != null && priceList.containsKey(newValue)) {
      selectedType.value = newValue;
      autoAmount.value = priceList[newValue]!;
    }
  }

  // Logic: Add Car to Database
  Future<void> addCar(String carNumber) async {
    // 1. Sanitize Input
    String cleanCarNumber = carNumber.trim().toUpperCase();

    // 2. Validate
    if (cleanCarNumber.isEmpty || cleanCarNumber.length < 3) {
      Get.snackbar(
        "Invalid Input",
        "Please enter a valid vehicle number (min 3 chars)",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // 3. Gather Data
      // Ensure LoginVM actually has values, otherwise provide defaults or handle error
      String userId = loginVM.userId.value;
      String lane = loginVM.laneNumber.value;

      if (userId.isEmpty || lane.isEmpty) {
        throw Exception("Operator session invalid. Please re-login.");
      }

      // 4. Call Repo
      await tollRepo.addCarLog(
        cleanCarNumber,
        autoAmount.value,
        lane,
        userId,
        selectedType.value,
      );

      // 5. Success UI
      Get.back(); // Close dialog
      Get.snackbar(
        "Success",
        "$cleanCarNumber (${selectedType.value}) Logged!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
