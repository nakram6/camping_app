import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatefulWidget {
const LocationScreen({
super.key,
});

@override
State<LocationScreen> createState() =>
_LocationScreenState();
}

class _LocationScreenState
extends State<LocationScreen> {
Position? position;

bool loading = true;

String errorMessage = '';

@override
void initState() {
super.initState();


getLocation();


}

Future<void> getLocation() async {
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
        LocationAccuracy.high,
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
    'Location Error: $e',
  );
}


}

@override
Widget build(
BuildContext context) {
return Scaffold(
backgroundColor:
Colors.green.shade50,
appBar: AppBar(
title:
const Text(
'My Location',
),
backgroundColor:
Colors.green,
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
style:
const TextStyle(
fontSize: 18,
),
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
Icons.location_on,
size: 120,
color:
Colors.red,
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
                              "Current Location",
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
                              "Latitude",
                              style:
                                  TextStyle(
                                color: Colors
                                    .grey,
                              ),
                            ),

                            Text(
                              position!
                                  .latitude
                                  .toStringAsFixed(
                                      6),
                              style:
                                  const TextStyle(
                                fontSize:
                                    20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height:
                                  15,
                            ),

                            Text(
                              "Longitude",
                              style:
                                  TextStyle(
                                color: Colors
                                    .grey,
                              ),
                            ),

                            Text(
                              position!
                                  .longitude
                                  .toStringAsFixed(
                                      6),
                              style:
                                  const TextStyle(
                                fontSize:
                                    20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height:
                                  15,
                            ),

                            Text(
                              "Accuracy",
                              style:
                                  TextStyle(
                                color: Colors
                                    .grey,
                              ),
                            ),

                            Text(
                              "${position!.accuracy.toStringAsFixed(1)} m",
                              style:
                                  const TextStyle(
                                fontSize:
                                    20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 320,
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
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                                    Icons
                                        .location_pin,
                                    color:
                                        Colors.red,
                                    size:
                                        50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton.icon(
                        onPressed:
                            getLocation,
                        icon:
                            const Icon(
                          Icons.refresh,
                        ),
                        label:
                            const Text(
                          "Refresh Location",
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
