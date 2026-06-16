import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/location/qibla_service.dart';
import '../../widgets/qibla_compass.dart';

class QiblaScreen extends StatefulWidget {
const QiblaScreen({super.key});

@override
State<QiblaScreen> createState() =>
_QiblaScreenState();
}

class _QiblaScreenState
extends State<QiblaScreen> {
double heading = 0;
double qiblaDirection = 0;
double distanceToKaaba = 0;

bool loading = true;
String errorMessage = '';

bool get isFacingQibla {
final difference =
(qiblaDirection - heading).abs();


return difference <= 10;


}

double get qiblaDifference {
double diff =
qiblaDirection - heading;


while (diff > 180) {
  diff -= 360;
}

while (diff < -180) {
  diff += 360;
}

return diff;


}

String get directionText {
final diff =
qiblaDifference.abs();


if (diff <= 5) {
  return "🟢 Facing Qibla";
}

if (diff <= 15) {
  return "🟡 Almost There";
}

if (qiblaDifference > 0) {
  return "➡️ Turn Right ${diff.toStringAsFixed(0)}°";
}

return "⬅️ Turn Left ${diff.toStringAsFixed(0)}°";


}

@override
void initState() {
super.initState();
initializeQibla();
}

Future<void> initializeQibla() async {
try {
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

  final position =
      await Geolocator.getCurrentPosition();

  qiblaDirection =
      QiblaService.calculateQibla(
    position.latitude,
    position.longitude,
  );

  distanceToKaaba =
      QiblaService.distanceToKaaba(
    position.latitude,
    position.longitude,
  );

  FlutterCompass.events?.listen(
    (event) {
      if (!mounted) return;

      setState(() {
        heading =
            event.heading ?? 0;
      });
    },
  );

  setState(() {
    loading = false;
  });
} catch (e) {
  setState(() {
    errorMessage =
        'Unable to calculate Qibla';
    loading = false;
  });

  debugPrint(
    'Qibla Error: $e',
  );
}


}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor:
Colors.green.shade50,
appBar: AppBar(
title: const Text(
'Qibla Direction',
),
centerTitle: true,
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
20,
),
child: Column(
children: [
const SizedBox(
height: 20,
),


                    const Text(
                      'Find the Direction of Makkah',
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        fontSize:
                            24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Rotate your phone until the green arrow points toward the Kaaba.',
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        fontSize:
                            16,
                        color: Colors
                            .grey,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    QiblaCompass(
                      heading:
                          heading,
                      qiblaDirection:
                          qiblaDirection,
                    ),

                    const SizedBox(
                      height: 25,
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
                      child:
                          Padding(
                        padding:
                            const EdgeInsets.all(
                          20,
                        ),
                        child:
                            Column(
                          children: [
                            Text(
                              directionText,
                              textAlign:
                                  TextAlign.center,
                              style:
                                  const TextStyle(
                                fontSize:
                                    22,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height:
                                  15,
                            ),

                            Text(
                              "Qibla Bearing: ${qiblaDirection.toStringAsFixed(1)}°",
                            ),

                            Text(
                              "Heading: ${heading.toStringAsFixed(1)}°",
                            ),

                            const SizedBox(
                              height:
                                  10,
                            ),

                            Text(
                              "${distanceToKaaba.toStringAsFixed(0)} km to Makkah",
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal:
                            24,
                        vertical:
                            14,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            isFacingQibla
                                ? Colors.green
                                : Colors.orange,
                        borderRadius:
                            BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: Text(
                        directionText,
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize:
                              18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
);


}
}
