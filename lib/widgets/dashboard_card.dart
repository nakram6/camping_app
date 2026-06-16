import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
final IconData icon;
final String title;
final VoidCallback onTap;

const DashboardCard({
super.key,
required this.icon,
required this.title,
required this.onTap,
});

Color getIconColor() {
switch (title) {
case "Weather":
return Colors.orange;
case "Qibla":
return Colors.green;
case "Offline Map":
return Colors.blue;
case "Checklist":
return Colors.purple;
case "Emergency":
return Colors.red;
case "Journal":
return Colors.brown;
case "Members":
return Colors.teal;
case "Photos":
return Colors.pink;
default:
return Colors.indigo;
}
}

@override
Widget build(BuildContext context) {
return Card(
elevation: 6,
shadowColor: Colors.black26,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
child: InkWell(
borderRadius: BorderRadius.circular(20),
onTap: onTap,
child: Padding(
padding: const EdgeInsets.all(12),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
icon,
size: 50,
color: getIconColor(),
),
const SizedBox(height: 12),
Text(
title,
textAlign: TextAlign.center,
style: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
],
),
),
),
);
}
}
