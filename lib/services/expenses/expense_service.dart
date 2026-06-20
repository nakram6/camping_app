import 'package:hive/hive.dart';

class ExpenseService {
  static Box get box =>
      Hive.box('settings');

  static Future<void> saveExpenses(
    String tripName,
    List<Map<String, dynamic>> expenses,
  ) async {
    await box.put(
      'expenses_$tripName',
      expenses,
    );
  }

  static List<Map<String, dynamic>>
      loadExpenses(
    String tripName,
  ) {
    final data = box.get(
      'expenses_$tripName',
      defaultValue: [],
    );

    return List<Map<String, dynamic>>.from(
      (data as List).map(
        (e) =>
            Map<String, dynamic>.from(e),
      ),
    );
  }
}