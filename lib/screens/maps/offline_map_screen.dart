import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OfflineMapScreen extends StatelessWidget {
  const OfflineMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const LatLng windsor = LatLng(
      42.3149,
      -83.0364,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Maps",
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: windsor,
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'com.nadeemakram.campingcompanion',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: windsor,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}