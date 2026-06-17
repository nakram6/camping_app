import 'package:hive/hive.dart';

class PhotoService {
  static Box get box =>
      Hive.box('settings');

  static Future<void> savePhotos(
    String tripName,
    List<String> photos,
  ) async {
    await box.put(
      'photos_$tripName',
      photos,
    );
  }

  static List<String> loadPhotos(
    String tripName,
  ) {
    final data = box.get(
      'photos_$tripName',
      defaultValue: [],
    );

    return List<String>.from(data);
  }
}