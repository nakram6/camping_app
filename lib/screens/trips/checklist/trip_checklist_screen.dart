import 'package:flutter/material.dart';

class TripChecklistScreen extends StatelessWidget {
final String tripName;

const TripChecklistScreen({
super.key,
required this.tripName,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"$tripName Checklist",
),
),
body: const Center(
child: Text(
"Trip Checklist Coming Soon",
style: TextStyle(
fontSize: 22,
),
),
),
);
}
}
