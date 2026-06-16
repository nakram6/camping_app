import 'package:flutter/material.dart';

class TripMembersScreen extends StatelessWidget {
final String tripName;

const TripMembersScreen({
super.key,
required this.tripName,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"$tripName Members",
),
),
body: const Center(
child: Text(
"Trip Members Coming Soon",
style: TextStyle(
fontSize: 22,
),
),
),
);
}
}
