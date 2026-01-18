import 'package:get/get.dart';

import '../data/repos/TollRepo.dart';
import '../ui/home/HomeVM.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TollRepo());
    Get.put(HomeVM(), permanent: true);
  }
}
