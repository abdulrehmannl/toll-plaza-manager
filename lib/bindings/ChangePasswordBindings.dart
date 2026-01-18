import 'package:digi_wallett/ui/auth/ChangePasswordVM.dart';
import 'package:get/get.dart';

class ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordVM>(() => ChangePasswordVM());
  }
}
