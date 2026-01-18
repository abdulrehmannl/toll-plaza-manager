import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../firebase_options.dart'; // Ensure this matches your project structure

import '../auth/LoginVM.dart'; // Import your VM

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    // 1. Initialize Firebase & Storage (The "Heavy" lifting)
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await GetStorage.init();

    // 2. Put the LoginVM (So we can check logic)
    // Note: We use Get.put directly here since we aren't using a Binding for Splash
    final LoginVM loginVM = Get.put(LoginVM());

    // 3. Optional: Add a small delay so the user sees the logo (e.g., 2 seconds)
    // Remove this line if you want it to be instant.
    await Future.delayed(const Duration(seconds: 2));

    // 4. Logic: Check where to go
    // We check GetStorage (Local Memory) OR FirebaseAuth
    if (loginVM.isAlreadyLoggedIn()) {
      // Refresh user details in background if needed
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await loginVM.loadUserDetails(uid);

      // Redirect
      if (loginVM.userRole.value == 'admin') {
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/home');
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800, // Background Color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- YOUR LOGO ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5)
                    )
                  ]
              ),
              child: Icon(Icons.toll, size: 60, color: Colors.teal.shade800),
            ),
            const SizedBox(height: 20),

            // --- APP NAME ---
            const Text(
              "Toll Plaza Manager",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2
              ),
            ),
            const SizedBox(height: 40),

            // --- LOADER ---
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}