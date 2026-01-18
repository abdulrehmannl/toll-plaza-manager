import 'package:cloud_firestore/cloud_firestore.dart'; // REQUIRED for Timestamp

class TollCar {
  final String id;
  final String carNumber;
  final double tollAmount;
  final String laneNumber;
  final String operatorId;
  final String vehicleType;
  final DateTime createdAt;

  TollCar({
    required this.id,
    required this.carNumber,
    required this.tollAmount,
    required this.laneNumber,
    required this.operatorId,
    required this.vehicleType,
    required this.createdAt,
  });

  factory TollCar.fromMap(Map<String, dynamic> data) {
    return TollCar(
      id: data['id'] ?? '',
      carNumber: data['carNumber'] ?? 'Unknown',
      // Handle int or double for amount
      tollAmount: (data['tollAmount'] is int)
          ? (data['tollAmount'] as int).toDouble()
          : (data['tollAmount'] ?? 0.0),
      laneNumber: data['laneNumber'] ?? '',
      operatorId: data['operatorId'] ?? '',
      vehicleType: data['vehicleType'] ?? 'Car',
      // CRITICAL FIX: Handle both Timestamp and String
      createdAt: _parseDate(data['createdAt']),
    );
  }

  // Helper function to safely parse dates from Firestore
  static DateTime _parseDate(dynamic date) {
    if (date == null) return DateTime.now();
    if (date is Timestamp) return date.toDate(); // Handle Firestore Timestamp
    if (date is String)
      return DateTime.tryParse(date) ?? DateTime.now(); // Handle String
    return DateTime.now(); // Fallback
  }

  Map<String, dynamic> toMap() {
    return {
      'carNumber': carNumber,
      'tollAmount': tollAmount,
      'laneNumber': laneNumber,
      'operatorId': operatorId,
      'vehicleType': vehicleType,
      // We save as ISO String to keep it simple, but the parser above handles everything
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
