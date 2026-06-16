import 'package:flutter/material.dart';

class TripPhotosScreen extends StatelessWidget {
final String tripName;

const TripPhotosScreen({
super.key,
required this.tripName,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"$tripName Photos",
),
),
body: const Center(
child: Text(
"Trip Photos Coming Soon",
style: TextStyle(
fontSize: 22,
),
),
),
);
}
}
