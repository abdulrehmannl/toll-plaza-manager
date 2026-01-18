import 'package:digi_wallett/ui/auth/LoginVM.dart';
import 'package:get/get.dart';

import '../data/repos/AuthRepo.dart';
import '../ui/auth/ForgotPasswordVM.dart';

class LoginBindings extends Bindings {
  // Binding is a class of GetX
  @override
  void dependencies() {
    // it must have this method
    // first check k login page ki kon kon si dependencies hain
    // how do we know that an object of class is making???
    // -> when we see class name and the parenthesis like LoginVM()' you can also check it by looking at the imports
    // but LoginVM() ko create krna k liya bhi ek dependency hy called AuthRepo()
    // now LoginVm() needs AuthRepo(), is called Transitive Dependency, one needs another
    // so create both in binding class,
    // which one will be first?
    // transitive one will be first, (AuthRepo, obvious)

    Get.put(AuthRepo());
    Get.put(LoginVM());
    Get.lazyPut(() => ForgotPasswordVM());
  }
}
