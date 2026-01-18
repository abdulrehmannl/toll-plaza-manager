import 'package:get/get.dart';

import '../ui/auth/SignUpVM.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpVM());
  }
}
