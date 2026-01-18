// import 'package:digi_wallett/bindings/AddCarBindings.dart';
// import 'package:digi_wallett/bindings/LoginBindings.dart';
// import 'package:digi_wallett/bindings/SignUpBindings.dart';
// import 'package:digi_wallett/ui/addCar/AddCarPage.dart';
// import 'package:digi_wallett/ui/admin/AdminHomePage.dart';
// import 'package:digi_wallett/ui/auth/ChangePasswordPage.dart';
// import 'package:digi_wallett/ui/auth/ForgotPasswordPage.dart';
// import 'package:digi_wallett/ui/auth/LoginPage.dart';
// import 'package:digi_wallett/ui/auth/SignUpPage.dart';
// import 'package:digi_wallett/ui/home/HomePage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'ui/splash/SplashPage.dart';
// import 'bindings/AdminBindings.dart';
// import 'bindings/ChangePasswordBindings.dart';
// import 'bindings/HomeBindings.dart';
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   // FIX 1: Set the initial route based on the synchronous check.
//   // The LoginVM.onReady() will handle the robust persistence check and redirection.
//   final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
//
//   runApp(
//     GetMaterialApp(
//       title: 'Toll Plaza Management App',
//       // Updated title
//       initialBinding: LoginBindings(),
//       // Your professor's initial binding
//       debugShowCheckedModeBanner: false,
//
//       // Use the determined route
//       initialRoute: isLoggedIn ? '/home' : '/login',
//
//       getPages: [
//         GetPage(
//           name: '/home',
//           page: () => HomePage(),
//           binding: HomeBindings(),
//           transition: Transition.fadeIn,
//           transitionDuration: Duration(milliseconds: 500),
//         ),
//         GetPage(
//           name: '/login',
//           page: () => LoginPage(),
//           binding: LoginBindings(),
//           transition: Transition.fadeIn,
//           transitionDuration: Duration(milliseconds: 500),
//         ),
//         GetPage(
//           name: '/signup',
//           page: () => SignUpPage(),
//           binding: SignUpBindings(),
//           transition: Transition.fadeIn,
//           transitionDuration: Duration(milliseconds: 500),
//         ),
//         GetPage(name: '/forgot', page: () => ForgotPasswordPage()),
//         GetPage(
//           name: "/change-password",
//           page: () => ChangePasswordPage(),
//           binding: ChangePasswordBindings(),
//         ),
//         GetPage(
//           name: '/addCar',
//           page: () => AddCarPage(),
//           binding: AddCarBindings(),
//         ),
//         GetPage(
//           name: '/admin',
//           page: () => AdminHomePage(),
//           binding: AdminBinding(),
//         ),
//       ],
//     ),
//   );
// }
//
// // in provider you extends it using change Notifier but in GetX you extends it using GetX controller
// // in that you have a state variable is a normal variable and did apply changes using changeNotifier when value get changes
// // here in getX we did not have a normal variables but we will have a observable variables (obs)
// // as we did int isLoading variable and we access using isLoading.value (value) and in view how we observe it?
// // in provider we did it like context.watch<name>() but here we wrap the widget with Obx builder, where we want to observe it or want to change the variables value and only the
// // widget inside the Obx will rebuild , other remains the same no rebuild
// // this is the efficiency of it (Obx)
import 'package:digi_wallett/bindings/AddCarBindings.dart';
import 'package:digi_wallett/bindings/LoginBindings.dart';
import 'package:digi_wallett/bindings/SignUpBindings.dart';
import 'package:digi_wallett/ui/addCar/AddCarPage.dart';
import 'package:digi_wallett/ui/admin/AdminHomePage.dart';
import 'package:digi_wallett/ui/auth/ChangePasswordPage.dart';
import 'package:digi_wallett/ui/auth/ForgotPasswordPage.dart';
import 'package:digi_wallett/ui/auth/LoginPage.dart';
import 'package:digi_wallett/ui/auth/SignUpPage.dart';
import 'package:digi_wallett/ui/home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/splash/SplashPage.dart';
import 'bindings/AdminBindings.dart';
import 'bindings/ChangePasswordBindings.dart';
import 'bindings/HomeBindings.dart';
import 'firebase_options.dart';

// --- NEW CODE: Change to void main() without async/await for instant launch ---
void main() {
// --- OLD CODE (Commented Out) ---
// Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // --- OLD CODE (Moved to SplashPage) ---
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // --- OLD CODE (Logic moved to SplashPage) ---
  // FIX 1: Set the initial route based on the synchronous check.
  // The LoginVM.onReady() will handle the robust persistence check and redirection.
  // final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

  runApp(
    GetMaterialApp(
      title: 'Toll Plaza Management App',
      // Updated title

      // --- OLD CODE (Commented Out: We load bindings lazily now) ---
      // initialBinding: LoginBindings(),

      debugShowCheckedModeBanner: false,

      // --- NEW CODE: Point directly to SplashPage ---
      home: SplashPage(),

      // --- OLD CODE (Commented Out: SplashPage handles routing now) ---
      // Use the determined route
      // initialRoute: isLoggedIn ? '/home' : '/login',

      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBindings(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: LoginBindings(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpPage(),
          binding: SignUpBindings(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(name: '/forgot', page: () => ForgotPasswordPage()),
        GetPage(
          name: "/change-password",
          page: () => ChangePasswordPage(),
          binding: ChangePasswordBindings(),
        ),
        GetPage(
          name: '/addCar',
          page: () => AddCarPage(),
          binding: AddCarBindings(),
        ),
        GetPage(
          name: '/admin',
          page: () => AdminHomePage(),
          binding: AdminBinding(),
        ),
      ],
    ),
  );
}