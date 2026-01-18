import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. LOGIN
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 2. SIGNUP (UPDATED)
  // Fixes "Too many positional arguments" error
  Future<void> signup(String email, String password, String lane) async {
    try {
      // A. Create Authentication User
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // B. Save User Details to Firestore (Lane & Role)
      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'lane': lane, // <--- Saving the selected lane
        'role': 'operator', // <--- Default role
        'createdAt': FieldValue.serverTimestamp(),
      });

      // C. Send Verification Email
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      // Pass error back to UI
      throw e;
    }
  }

  // 3. FETCH USER DETAILS
  Future<Map<String, dynamic>?> fetchUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }

  // 4. RESET PASSWORD
  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // 5. CHANGE PASSWORD
  Future<void> changePassword(String newPassword) {
    return _auth.currentUser!.updatePassword(newPassword);
  }

  // 6. VERIFICATION
  Future<void> sendVerificationEmail() {
    return _auth.currentUser!.sendEmailVerification();
  }

  // 7. GET USER & LOGOUT
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
