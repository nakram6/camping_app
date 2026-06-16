import 'package:hive/hive.dart';

class TripService {
static Box get box =>
Hive.box('settings');

static Future<void> saveTrips(
List<Map<String, String>> trips,
) async {
await box.put(
'trips',
trips,
);
}

static List<Map<String, String>>
loadTrips() {
final data = box.get(
'trips',
defaultValue: [],
);


return List<Map<String, String>>.from(
  (data as List).map(
    (e) => Map<String, String>.from(e),
  ),
);


}
}
