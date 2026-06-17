import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/weather/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() =>
      _WeatherScreenState();
}

class _WeatherScreenState
    extends State<WeatherScreen> {
  final weatherService =
      WeatherService();

  Map<String, dynamic>? weather;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  Future<void> loadWeather() async {
    final position =
        await Geolocator.getCurrentPosition();

    weather =
        await weatherService.getWeather(
      position.latitude,
      position.longitude,
    );

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Weather"),
        backgroundColor:
            Colors.blue,
        foregroundColor:
            Colors.white,
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : weather == null
              ? const Center(
                  child:
                      Text("No Weather Data"),
                )
              : Center(
                  child: Card(
                    margin:
                        const EdgeInsets.all(
                            20),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                              20),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Text(
                            weather!["name"],
                            style:
                                const TextStyle(
                              fontSize:
                                  24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              height: 10),
                          Text(
                            "${weather!["main"]["temp"]}°C",
                            style:
                                const TextStyle(
                              fontSize:
                                  50,
                            ),
                          ),
                          Text(
                            weather!["weather"][0]
                                ["description"],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}