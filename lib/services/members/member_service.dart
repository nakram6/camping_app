import 'package:hive/hive.dart';

class MemberService {
static Box get box =>
Hive.box('settings');

static Future<void> saveMembers(
String tripName,
List<Map<String, dynamic>>
members,
) async {
await box.put(
'members_$tripName',
members,
);
}

static List<Map<String, dynamic>>
loadMembers(
String tripName,
) {
final data = box.get(
'members_$tripName',
defaultValue: [],
);


return List<Map<String, dynamic>>.from(
  (data as List).map(
    (e) => Map<String, dynamic>.from(
      e,
    ),
  ),
);


}
}
