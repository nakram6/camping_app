```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreTripService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static String get userId =>
      FirebaseAuth
          .instance
          .currentUser!
          .uid;

  static Future<void> saveTrip({
    required String name,
    required String location,
    required String startDate,
    required String endDate,
    required String notes,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('trips')
        .add({
      'name': name,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'notes': notes,
      'createdAt':
          Timestamp.now(),
    });
  }

  static Stream<QuerySnapshot>
      loadTrips() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('trips')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();
  }

  static Future<void> deleteTrip(
    String tripId,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('trips')
        .doc(tripId)
        .delete();
  }
}

