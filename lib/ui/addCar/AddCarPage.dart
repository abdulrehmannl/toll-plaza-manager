import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AddCarVM.dart';

class AddCarPage extends StatelessWidget {
  final AddCarVM vm = Get.put(AddCarVM()); // Logic
  final TextEditingController carNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("New Entry"),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // --- 1. CAR NUMBER INPUT ---
            TextField(
              controller: carNumberController,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: "Vehicle Number",
                hintText: "ABC-123",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.confirmation_number_outlined,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- 2. NEW BEAUTIFUL DROPDOWN ---
            Obx(
                  () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  border: Border.all(
                    color: Colors.teal.shade300,
                    width: 1.5,
                  ), // Teal border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2), // Soft shadow
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: vm.selectedType.value,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.teal.shade700,
                    ),
                    iconSize: 28,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 4,
                    items: vm.priceList.keys.map((String type) {
                      // Helper to pick the right icon
                      IconData iconData;
                      if (type == "Bike") {
                        iconData = Icons.two_wheeler;
                      } else if (type == "Truck") {
                        iconData = Icons.local_shipping;
                      } else {
                        iconData = Icons.directions_car;
                      }

                      // Logic to highlight the currently selected item color
                      bool isSelected = vm.selectedType.value == type;
                      Color itemColor =
                      isSelected ? Colors.teal : Colors.grey.shade700;

                      return DropdownMenuItem<String>(
                        value: type,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: itemColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(iconData, color: itemColor, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              type,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => vm.updateType(val),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- 3. TOLL AMOUNT DISPLAY ---
            Obx(
                  () => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal.shade200, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "TOLL AMOUNT",
                      style: TextStyle(
                        color: Colors.teal.shade800,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$${vm.autoAmount.value}",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        vm.selectedType.value,
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // --- 4. SUBMIT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  if (carNumberController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Enter Vehicle Number",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    vm.addCar(carNumberController.text);
                  }
                },
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                label: const Text(
                  "GENERATE TICKET",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}