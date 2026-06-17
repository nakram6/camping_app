import 'package:hive/hive.dart';

class JournalService {
static Box get box =>
Hive.box('settings');

static Future<void> saveJournal(
String tripName,
String text,
) async {
await box.put(
'journal_$tripName',
text,
);
}

static String loadJournal(
String tripName,
) {
return box.get(
'journal_$tripName',
defaultValue: '',
);
}
}
