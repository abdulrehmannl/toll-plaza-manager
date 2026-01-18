import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/TollCar.dart';

class TollRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'toll_logs';

  // 1. ADD NEW CAR
  Future<void> addCarLog(
      String carNo,
      double amount,
      String lane,
      String uid,
      String type,
      ) async {
    try {
      DocumentReference docRef = _firestore.collection(collectionPath).doc();

      await docRef.set({
        'carNumber': carNo,
        'tollAmount': amount,
        'laneNumber': lane,
        'operatorId': uid,
        'vehicleType': type,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception("Repo Error: $e");
    }
  }

  // 2. GET CARS FOR SPECIFIC OPERATOR
  Stream<List<TollCar>> getCarsByOperator(String uid) {
    return _firestore
        .collection(collectionPath)
        .where('operatorId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return TollCar.fromMap(data);
      }).toList();
    });
  }

  // 3. GET ALL LOGS (Called by AdminVM)
  Stream<List<TollCar>> getAllLogs() {
    return _firestore
        .collection(collectionPath)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return TollCar.fromMap(data);
      }).toList();
    });
  }

  // 4. DELETE CAR
  Future<void> deleteCarLog(String docId) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  // 5. UPDATE CAR
  Future<void> updateCarNumber(String docId, String newCarNumber) async {
    await _firestore.collection(collectionPath).doc(docId).update({
      'carNumber': newCarNumber,
    });
  }
}