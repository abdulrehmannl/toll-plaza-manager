import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // REQUIRED for DateFormat
import '../../utils/PdfHelper.dart';
import '../auth/LoginVM.dart';
import 'AdminVM.dart';
import 'AdminUsersPage.dart';

class AdminHomePage extends StatelessWidget {
  final AdminVM adminVM = Get.find();
  final LoginVM loginVM = Get.find();

  // Helper to format Time (10:30 AM)
  String formatTime(DateTime dt) {
    return DateFormat('h:mm a').format(dt);
  }

  // Helper to format the Title (Jan 18, 2024)
  String getTitleDate(DateTime dt) {
    return DateFormat('MMM dd, yyyy').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // DYNAMIC TITLE: Shows which date you are looking at
        title: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dashboard", style: TextStyle(fontSize: 16)),
            Text(
                getTitleDate(adminVM.selectedDate.value),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)
            ),
          ],
        )),
        backgroundColor: Colors.teal.shade900,
        actions: [
          // --- 1. CALENDAR BUTTON (NEW!) ---
          IconButton(
            icon: const Icon(Icons.calendar_month,color: Colors.white,),
            tooltip: "Select Date",
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: adminVM.selectedDate.value,
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(), // Can't pick future
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(primary: Colors.teal.shade800),
                      ),
                      child: child!,
                    );
                  }
              );
              if (picked != null) {
                adminVM.pickDate(picked);
              }
            },
          ),

          // --- 2. MANAGE USERS ---
          IconButton(
            icon: const Icon(Icons.people,color: Colors.white,),
            onPressed: () => Get.to(() => const AdminUsersPage()),
          ),

          // --- 3. EXPORT PDF ---
          IconButton(
            icon: const Icon(Icons.picture_as_pdf,color: Colors.white,),
            onPressed: () {
              if (adminVM.currentCars.isEmpty) {
                Get.snackbar("Empty", "No records for this date");
              } else {
                PdfHelper.generateAndPrint(adminVM.currentCars);
              }
            },
          ),

          // --- 4. LOGOUT ---
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: () => loginVM.logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. STATS CARDS (Dynamic based on Date)
          Obx(
                () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.teal.shade700, borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          const Text("Revenue", style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 5),
                          Text(
                            "\$${adminVM.totalRevenue.toStringAsFixed(0)}",
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.teal.shade200)),
                      child: Column(
                        children: [
                          const Text("Vehicles", style: TextStyle(color: Colors.teal)),
                          const SizedBox(height: 5),
                          Text(
                            "${adminVM.totalTraffic}",
                            style: TextStyle(color: Colors.teal.shade800, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(thickness: 1),

          // 2. LIST HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                  // "History: Jan 18" or "Today's Activity"
                  (adminVM.selectedDate.value.day == DateTime.now().day)
                      ? "Live Activity (Today)"
                      : "History: ${DateFormat('MMM dd').format(adminVM.selectedDate.value)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                )),
              ],
            ),
          ),

          // 3. THE LIST
          Expanded(
            child: Obx(() {
              if (adminVM.currentCars.isEmpty) {
                return const Center(child: Text("No records found for this date."));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: adminVM.currentCars.length,
                itemBuilder: (context, index) {
                  var car = adminVM.currentCars[index];
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        child: Text(car.laneNumber, style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(car.carNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${car.vehicleType} • Op: ${adminVM.getShortId(car.operatorId) ?? ''}", style: const TextStyle(fontSize: 12)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("\$${car.tollAmount.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          Text(formatTime(car.createdAt), style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Small helper for AdminVM inside this file (or put in VM)
extension AdminVMExt on AdminVM {
  String getShortId(String id) {
    if (id.isEmpty) return "Unknown";
    if (id.length <= 4) return id;
    return "...${id.substring(id.length - 4)}";
  }
}