import 'package:get/get.dart';

import '../../data/repos/TollRepo.dart';
import '../ui/admin/AdminVM.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminVM>(() => AdminVM());
    Get.lazyPut<TollRepo>(() => TollRepo());
  }
}

// 1. Inject the Repo first (so VM can find it)
// 2. Inject the ViewModel
