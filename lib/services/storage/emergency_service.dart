import 'package:hive/hive.dart';

class EmergencyService {
static Box get box =>
Hive.box('settings');

static Future<void> saveContacts(
List<Map<String, String>> contacts,
) async {
await box.put(
'emergency_contacts',
contacts,
);
}

static List<Map<String, String>>
loadContacts() {
final data = box.get(
'emergency_contacts',
defaultValue: [],
);


return List<Map<String, String>>.from(
  (data as List).map(
    (e) => Map<String, String>.from(e),
  ),
);


}
}
