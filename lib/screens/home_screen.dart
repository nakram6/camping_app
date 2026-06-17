import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/welcome_banner.dart';
import 'checklist/checklist_screen.dart';
import 'weather/weather_screen.dart';
import 'ai/ai_assistant_screen.dart';
import 'qibla/qibla_screen.dart';
import 'emergency/emergency_screen.dart';
import 'trips/trip_screen.dart';
import 'maps/offline_map_screen.dart';
import 'settings/settings_screen.dart';
import 'location/location_screen.dart';
import 'location/nearby_places_screen.dart';
import 'emergency/sos_screen.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int currentIndex = 0;

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey[100],


  appBar: AppBar(
    title: const Text("Camping Companion"),
    centerTitle: true,
    elevation: 0,
  ),

  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        const WelcomeBanner(),

        const SizedBox(height: 20),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            DashboardCard(
  icon: Icons.wb_sunny,
  title: "Weather",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const WeatherScreen(),
      ),
    );
  },
),


           DashboardCard(
  icon: Icons.explore,
  title: "Qibla",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const QiblaScreen(),
      ),
    );
  },
),

            DashboardCard(
  icon: Icons.map,
  title: "Maps",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const OfflineMapScreen(),
      ),
    );
  },
),
            DashboardCard(
              icon: Icons.check_circle,
              title: "Checklist",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChecklistScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
icon: Icons.smart_toy,
title: "AI Guide",
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const AIAssistantScreen(),
),
);
},
),
DashboardCard(
  icon: Icons.forest,
  title: "Trips",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const TripScreen(),
      ),
    );
  },
),


            

            DashboardCard(
              icon: Icons.book,
              title: "Journal",
              onTap: () {},
            ),

            DashboardCard(
              icon: Icons.people,
              title: "Members",
              onTap: () {},
            ),

DashboardCard(
  icon: Icons.location_on,
  title: "Location",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LocationScreen(),
      ),
    );
  },
),

DashboardCard(
  icon: Icons.place,
  title: "Nearby",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const NearbyPlacesScreen(),
      ),
    );
  },
),

DashboardCard(
  icon: Icons.sos,
  title: "SOS",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const SOSScreen(),
      ),
    );
  },
),



            DashboardCard(
              icon: Icons.photo_camera,
              title: "Photos",
              onTap: () {},
            ),

DashboardCard(
  icon: Icons.settings,
  title: "Settings",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
             const AISettingsScreen(),
      ),
    );
  },
),



DashboardCard(
  icon: Icons.emergency,
  title: "Emergency",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const EmergencyScreen(),
      ),
    );
  },
),





          ],
        ),
      ],
    ),
  ),

  bottomNavigationBar: BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      setState(() {
        currentIndex = index;
      });
    },
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: "Explore",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: "Group",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),
    ],
  ),
);


}
}
