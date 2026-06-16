import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
const ChecklistScreen({super.key});

@override
State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
final List<Map<String, dynamic>> items = [
{"name": "Tent", "checked": false},
{"name": "Sleeping Bag", "checked": false},
{"name": "Food", "checked": false},
{"name": "Flashlight", "checked": false},
{"name": "Water", "checked": false},
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Camping Checklist"),
),
body: ListView.builder(
itemCount: items.length,
itemBuilder: (context, index) {
return CheckboxListTile(
title: Text(items[index]["name"]),
value: items[index]["checked"],
onChanged: (value) {
setState(() {
items[index]["checked"] = value;
});
},
);
},
),
);
}
}
