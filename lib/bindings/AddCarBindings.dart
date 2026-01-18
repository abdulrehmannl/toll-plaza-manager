import 'package:get/get.dart';

import '../../data/repos/TollRepo.dart';
import '../ui/addCar/AddCarVM.dart';

class AddCarBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TollRepo());
    Get.put(AddCarVM());
  }
}
