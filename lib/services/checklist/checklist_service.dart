import 'package:hive/hive.dart';

class ChecklistService {
static Box get box =>
Hive.box('settings');

static Future<void> saveItems(
String tripName,
List<Map<String, dynamic>> items,
) async {
await box.put(
'checklist_$tripName',
items,
);
}

static List<Map<String, dynamic>>
loadItems(
String tripName,
) {
final data = box.get(
'checklist_$tripName',
defaultValue: [],
);


return List<Map<String, dynamic>>.from(
  data,
);


}
}
