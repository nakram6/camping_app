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
import 'members/all_members_screen.dart';
import '../services/trips/trip_service.dart';
import '../services/trips/current_trip_service.dart';
import 'games/games_screen.dart';


class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  String selectedTrip = "";

  List<Map<String, String>> trips = [];

  @override
  void initState() {
    super.initState();

    trips = TripService.loadTrips();

    selectedTrip =
        CurrentTripService.loadCurrentTrip();

    if (selectedTrip.isEmpty &&
        trips.isNotEmpty) {
      selectedTrip =
          trips.first["name"] ?? "";
    }
  }

  Future<void> selectTrip() async {
    trips = TripService.loadTrips();

    if (trips.isEmpty) return;

    final selected =
        await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Select Trip"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: trips.length,
              itemBuilder:
                  (context, index) {
                return ListTile(
                  title: Text(
                    trips[index]["name"] ??
                        "",
                  ),
                  onTap: () {
                    Navigator.pop(
                      context,
                      trips[index]["name"],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selected != null) {
      await CurrentTripService
          .saveCurrentTrip(
        selected,
      );

      setState(() {
        selectedTrip = selected;
      });
    }
  }

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

const SizedBox(height: 16),

Card(
  elevation: 4,
  child: ListTile(
    leading: const Icon(
      Icons.forest,
      color: Colors.green,
    ),
    title: Text(
      selectedTrip.isEmpty
          ? "No Trip Selected"
          : selectedTrip,
    ),
    subtitle:
        const Text("Current Trip"),
    trailing: IconButton(
      icon: const Icon(
        Icons.swap_horiz,
      ),
      onPressed: selectTrip,
    ),
  ),
),

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
  icon: Icons.games,
  title: "Games",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const GamesScreen(),
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
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const AllMembersScreen(),
      ),
    );
  },
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
