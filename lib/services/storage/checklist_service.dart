import 'package:hive/hive.dart';

class ChecklistService {
static Box get box =>
Hive.box('checklist');

static List<String> getItems() {
return box.get(
'items',
defaultValue: <String>[],
).cast<String>();
}

static Future<void> saveItems(
List<String> items) async {
await box.put(
'items',
items,
);
}
}
