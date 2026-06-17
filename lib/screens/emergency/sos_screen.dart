import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class SOSScreen extends StatefulWidget {
const SOSScreen({
super.key,
});

@override
State<SOSScreen> createState() =>
_SOSScreenState();
}

class _SOSScreenState
extends State<SOSScreen> {
Position? position;

bool loading = true;

String errorMessage = '';

@override
void initState() {
super.initState();


loadLocation();


}

Future<void> loadLocation() async {
try {
setState(() {
loading = true;
});


  LocationPermission permission =
      await Geolocator.checkPermission();

  if (permission ==
      LocationPermission.denied) {
    permission =
        await Geolocator.requestPermission();
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
  });
} catch (e) {
  setState(() {
    errorMessage =
        'Unable to get location';
    loading = false;
  });
}


}

Future<void> copySOS() async {
if (position == null) return;


final text = '''


EMERGENCY SOS

Latitude: ${position!.latitude}
Longitude: ${position!.longitude}

Please send help.
''';


await Clipboard.setData(
  ClipboardData(
    text: text,
  ),
);

if (!mounted) return;

ScaffoldMessenger.of(
  context,
).showSnackBar(
  const SnackBar(
    content:
        Text('SOS copied'),
  ),
);


}

@override
Widget build(
BuildContext context) {
return Scaffold(
backgroundColor:
Colors.red.shade50,
appBar: AppBar(
title:
const Text(
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
: Padding(
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
                    height: 20,
                  ),

                  const Text(
                    'Emergency Coordinates',
                    style:
                        TextStyle(
                      fontSize:
                          24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                        20,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Latitude\n${position!.latitude.toStringAsFixed(6)}',
                            textAlign:
                                TextAlign.center,
                          ),

                          const SizedBox(
                            height:
                                20,
                          ),

                          Text(
                            'Longitude\n${position!.longitude.toStringAsFixed(6)}',
                            textAlign:
                                TextAlign.center,
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
                          copySOS,
                      icon:
                          const Icon(
                        Icons.copy,
                      ),
                      label:
                          const Text(
                        'Copy SOS Coordinates',
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
);


}
}
