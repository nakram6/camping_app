import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() =>
      _SOSScreenState();
}

class _SOSScreenState
    extends State<SOSScreen> {
  Position? position;

  bool loading = true;

  String errorMessage = '';

  double heading = 0;

  @override
  void initState() {
    super.initState();

    loadLocation();

    FlutterCompass.events?.listen(
      (event) {
        if (!mounted) return;

        setState(() {
          heading =
              event.heading ?? 0;
        });
      },
    );
  }

  Future<void> loadLocation() async {
    try {
      setState(() {
        loading = true;
      });

      bool serviceEnabled =
          await Geolocator
              .isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() {
          errorMessage =
              'Location services are disabled';
          loading = false;
        });

        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission ==
          LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission ==
              LocationPermission.denied ||
          permission ==
              LocationPermission.deniedForever) {
        setState(() {
          errorMessage =
              'Location permission denied';
          loading = false;
        });

        return;
      }

      final currentPosition =
          await Geolocator
              .getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.best,
      );

      setState(() {
        position = currentPosition;
        loading = false;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage =
            'Unable to get location';
        loading = false;
      });

      debugPrint(
        'SOS Error: $e',
      );
    }
  }

  Future<void> copySOS() async {
    if (position == null) return;

    final now =
        DateTime.now();

    final text = '''
🚨 EMERGENCY SOS

Latitude:
${position!.latitude}

Longitude:
${position!.longitude}

Altitude:
${position!.altitude.toStringAsFixed(1)} m

Accuracy:
${position!.accuracy.toStringAsFixed(1)} m

Compass Heading:
${heading.toStringAsFixed(0)}°

Time:
$now

Please send help.
''';

    await Clipboard.setData(
      ClipboardData(text: text),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          'SOS copied',
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    final currentTime =
        DateTime.now();

    return Scaffold(
      backgroundColor:
          Colors.red.shade50,
      appBar: AppBar(
        title: const Text(
          'SOS Emergency',
        ),
        backgroundColor:
            Colors.red,
        foregroundColor:
            Colors.white,
      ),
      body: loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                            20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.sos,
                          size: 120,
                          color:
                              Colors.red,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          'Emergency SOS',
                          style:
                              TextStyle(
                            fontSize:
                                28,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Card(
                          elevation: 6,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(
                              20,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Emergency Information',
                                  style:
                                      TextStyle(
                                    fontSize:
                                        22,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                      20,
                                ),

                                Text(
                                  'Latitude\n${position!.latitude.toStringAsFixed(6)}',
                                  textAlign:
                                      TextAlign.center,
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                Text(
                                  'Longitude\n${position!.longitude.toStringAsFixed(6)}',
                                  textAlign:
                                      TextAlign.center,
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                Text(
                                  'Altitude\n${position!.altitude.toStringAsFixed(1)} m',
                                  textAlign:
                                      TextAlign.center,
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                Text(
                                  'Accuracy\n${position!.accuracy.toStringAsFixed(1)} m',
                                  textAlign:
                                      TextAlign.center,
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                Text(
                                  'Compass Heading\n${heading.toStringAsFixed(0)}°',
                                  textAlign:
                                      TextAlign.center,
                                ),

                                const SizedBox(
                                  height:
                                      12,
                                ),

                                Text(
                                  'Time\n$currentTime',
                                  textAlign:
                                      TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 300,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                            child: FlutterMap(
                              options:
                                  MapOptions(
                                initialCenter:
                                    LatLng(
                                  position!
                                      .latitude,
                                  position!
                                      .longitude,
                                ),
                                initialZoom:
                                    15,
                              ),
                              children: [
                               TileLayer(
  urlTemplate:
      'https://tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
  userAgentPackageName:
      'com.nadeemakram.campingcompanion',
),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point:
                                          LatLng(
                                        position!
                                            .latitude,
                                        position!
                                            .longitude,
                                      ),
                                      width:
                                          80,
                                      height:
                                          80,
                                      child:
                                          const Icon(
                                        Icons.location_pin,
                                        size:
                                            55,
                                        color:
                                            Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          width:
                              double.infinity,
                          child:
                              ElevatedButton.icon(
                            onPressed:
                                copySOS,
                            icon:
                                const Icon(
                              Icons.copy,
                            ),
                            label:
                                const Text(
                              'Copy SOS Message',
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          width:
                              double.infinity,
                          child:
                              ElevatedButton.icon(
                            onPressed:
                                loadLocation,
                            icon:
                                const Icon(
                              Icons.refresh,
                            ),
                            label:
                                const Text(
                              'Refresh',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

