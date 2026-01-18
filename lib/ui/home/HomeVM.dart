import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/TollRepo.dart';
import '../../models/TollCar.dart';
import '../auth/LoginVM.dart';

class HomeVM extends GetxController {
  final TollRepo tollRepo = Get.find<TollRepo>();
  final LoginVM loginVM = Get.find<LoginVM>();

  RxList<TollCar> allCars = <TollCar>[].obs;       // Raw data from DB
  RxList<TollCar> displayedCars = <TollCar>[].obs; // Data shown on screen (Today + Filtered)
  var searchQuery = ''.obs;

  StreamSubscription? _carLogSubscription;

  // Computed total (Based on what is displayed - i.e., Today)
  double get totalCollected =>
      displayedCars.fold(0, (sum, car) => sum + car.tollAmount);

  @override
  void onInit() {
    super.onInit();
    // Listen for User ID changes to fix "Timing" issues
    ever(loginVM.userId, (_) => loadData());
    loadData();
  }

  void loadData() {
    String uid = loginVM.userId.value;

    if (uid.isNotEmpty) {
      _carLogSubscription?.cancel();

      // Fetch cars specifically for this operator
      _carLogSubscription = tollRepo.getCarsByOperator(uid).listen((data) {
        allCars.assignAll(data);
        // Apply "Today" filter + Search filter immediately
        filterCars(searchQuery.value);
      });
    }
  }

  // Helper to check if a date is Today
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // SEARCH + DATE FILTER
  void filterCars(String query) {
    searchQuery.value = query;

    // 1. Filter by Today first
    var todayList = allCars.where((car) => isToday(car.createdAt)).toList();

    // 2. Filter by Search Query
    if (query.isEmpty) {
      displayedCars.assignAll(todayList);
    } else {
      var result = todayList.where((car) {
        return car.carNumber.toLowerCase().contains(query.toLowerCase());
      }).toList();
      displayedCars.assignAll(result);
    }
  }

  // EDIT LOG
  void showEditDialog(String docId, String currentNumber) {
    TextEditingController editCtrl = TextEditingController(text: currentNumber);
    Get.defaultDialog(
      title: "Edit Car Number",
      contentPadding: const EdgeInsets.all(16),
      content: TextField(
        controller: editCtrl,
        decoration: const InputDecoration(labelText: "Vehicle Number", border: OutlineInputBorder()),
      ),
      textConfirm: "Update",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        if (editCtrl.text.trim().length < 3) {
          Get.snackbar("Error", "Invalid Car Number");
          return;
        }
        await tollRepo.updateCarNumber(docId, editCtrl.text.trim().toUpperCase());
        Get.back();
        Get.snackbar("Success", "Record updated");
      },
    );
  }

  // DELETE LOG
  void deleteLog(String docId) {
    Get.defaultDialog(
      title: "Delete Entry",
      middleText: "Delete this record?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        tollRepo.deleteCarLog(docId);
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    _carLogSubscription?.cancel();
    super.onClose();
  }
}