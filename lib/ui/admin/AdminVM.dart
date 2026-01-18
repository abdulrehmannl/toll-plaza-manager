import 'package:get/get.dart';
import '../../data/repos/TollRepo.dart';
import '../../models/TollCar.dart';

class AdminVM extends GetxController {
  final TollRepo tollRepo = Get.find();

  // 1. Stores EVERYTHING (History)
  RxList<TollCar> allHistory = <TollCar>[].obs;

  // 2. Stores CURRENTLY VIEWED data (Filtered by Date)
  RxList<TollCar> currentCars = <TollCar>[].obs;

  // 3. The Date we are looking at (Default = Today)
  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    bindAllCarsStream();
  }

  void bindAllCarsStream() {
    tollRepo.getAllLogs().listen((data) {
      allHistory.assignAll(data);
      // Whenever database changes, re-filter for the currently selected date
      applyDateFilter();
    });
  }

  // --- LOGIC TO SWITCH DATES ---
  void pickDate(DateTime date) {
    selectedDate.value = date;
    applyDateFilter();
  }

  void applyDateFilter() {
    var dateToFind = selectedDate.value;

    var filtered = allHistory.where((car) {
      return car.createdAt.year == dateToFind.year &&
          car.createdAt.month == dateToFind.month &&
          car.createdAt.day == dateToFind.day;
    }).toList();

    currentCars.assignAll(filtered);
  }

  // CALCULATIONS (Based on the selected date)
  double get totalRevenue => currentCars.fold(0, (sum, car) => sum + car.tollAmount);
  int get totalTraffic => currentCars.length;
}