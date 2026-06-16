import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
const WelcomeBanner({super.key});

@override
Widget build(BuildContext context) {
return Container(
width: double.infinity,
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20),
gradient: const LinearGradient(
colors: [
Colors.green,
Colors.teal,
],
),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"Welcome Back 👋",
style: TextStyle(
color: Colors.white,
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 8),
Text(
"Next Camping Trip: 12 Days",
style: TextStyle(
color: Colors.white,
fontSize: 16,
),
),
],
),
);
}
}
