import 'package:hive/hive.dart';

class MemberService {
static Box get box =>
Hive.box('settings');

static Future<void> saveMembers(
String tripName,
List<String> members,
) async {
await box.put(
'members_$tripName',
members,
);
}

static List<String> loadMembers(
String tripName,
) {
final data = box.get(
'members_$tripName',
defaultValue: [],
);


return List<String>.from(data);


}
}
