import 'package:flutter/material.dart';

import '../checklist/trip_checklist_screen.dart';
import '../journal/trip_journal_screen.dart';
import '../members/trip_members_screen.dart';
import '../photos/trip_photos_screen.dart';

class TripDetailsScreen extends StatelessWidget {
final String tripName;

const TripDetailsScreen({
super.key,
required this.tripName,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(tripName),
backgroundColor:
Colors.green,
foregroundColor:
Colors.white,
),
body: Padding(
padding:
const EdgeInsets.all(16),
child: GridView.count(
crossAxisCount: 2,
crossAxisSpacing: 15,
mainAxisSpacing: 15,
children: [
_buildCard(
context,
Icons.check_circle,
"Checklist",
Colors.blue,
() {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
TripChecklistScreen(
tripName:
tripName,
),
),
);
},
),


        _buildCard(
          context,
          Icons.book,
          "Journal",
          Colors.orange,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TripJournalScreen(
                  tripName:
                      tripName,
                ),
              ),
            );
          },
        ),

        _buildCard(
          context,
          Icons.people,
          "Members",
          Colors.purple,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TripMembersScreen(
                  tripName:
                      tripName,
                ),
              ),
            );
          },
        ),

        _buildCard(
          context,
          Icons.photo,
          "Photos",
          Colors.teal,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TripPhotosScreen(
                  tripName:
                      tripName,
                ),
              ),
            );
          },
        ),

        _buildCard(
          context,
          Icons.cloud,
          "Weather",
          Colors.amber,
          () {},
        ),

        _buildCard(
          context,
          Icons.emergency,
          "Emergency",
          Colors.red,
          () {},
        ),
      ],
    ),
  ),
);


}

Widget _buildCard(
BuildContext context,
IconData icon,
String title,
Color color,
VoidCallback onTap,
) {
return InkWell(
onTap: onTap,
borderRadius:
BorderRadius.circular(
20,
),
child: Card(
elevation: 6,
shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
20,
),
),
child: Column(
mainAxisAlignment:
MainAxisAlignment
.center,
children: [
Icon(
icon,
size: 50,
color: color,
),
const SizedBox(
height: 10,
),
Text(
title,
style:
const TextStyle(
fontSize: 18,
fontWeight:
FontWeight.bold,
),
),
],
),
),
);
}
}
