import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPlacesScreen extends StatelessWidget {
  const NearbyPlacesScreen({
    super.key,
  });

  Future<void> openSearch(
    String query,
  ) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/$query',
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Widget placeButton(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: 35,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nearby Places",
        ),
        backgroundColor:
            Colors.green,
        foregroundColor:
            Colors.white,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(12),
        child: Column(
          children: [
            placeButton(
              Icons.park,
              "Campgrounds",
              Colors.green,
              () => openSearch(
                "campground near me",
              ),
            ),

            placeButton(
              Icons.local_gas_station,
              "Gas Stations",
              Colors.orange,
              () => openSearch(
                "gas station near me",
              ),
            ),

            placeButton(
              Icons.local_hospital,
              "Hospitals",
              Colors.red,
              () => openSearch(
                "hospital near me",
              ),
            ),

            placeButton(
              Icons.mosque,
              "Mosques",
              Colors.teal,
              () => openSearch(
                "mosque near me",
              ),
            ),

            placeButton(
              Icons.restaurant,
              "Food",
              Colors.purple,
              () => openSearch(
                "restaurant near me",
              ),
            ),

            placeButton(
              Icons.hiking,
              "Hiking Trails",
              Colors.brown,
              () => openSearch(
                "hiking trail near me",
              ),
            ),
          ],
        ),
      ),
    );
  }
}