import 'package:flutter/material.dart';

class TripJournalScreen extends StatelessWidget {
final String tripName;

const TripJournalScreen({
super.key,
required this.tripName,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"$tripName Journal",
),
),
body: const Center(
child: Text(
"Trip Journal Coming Soon",
style: TextStyle(
fontSize: 22,
),
),
),
);
}
}
