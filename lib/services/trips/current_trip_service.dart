import 'trip_service.dart';

class CurrentTripService {
  static Future<void> saveCurrentTrip(
    String tripName,
  ) async {
    await TripService.saveCurrentTrip(
      tripName,
    );
  }

  static String loadCurrentTrip() {
    return TripService.loadCurrentTrip();
  }
}