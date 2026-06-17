import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherService {
Future<Map<String, dynamic>?> getWeather(
double lat,
double lon,
) async {
try {
final apiKey =
dotenv.env['OPENWEATHER_API_KEY'];


  print(
    "Weather API Key: $apiKey",
  );

  final response = await http.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey',
    ),
  );

  print(
    "Status Code: ${response.statusCode}",
  );

  print(
    "Response Body: ${response.body}",
  );

  if (response.statusCode != 200) {
    return null;
  }

  return jsonDecode(
    response.body,
  );
} catch (e) {
  print(
    "Weather Error: $e",
  );

  return null;
}


}
}
