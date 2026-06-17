import 'package:flutter/material.dart';

import '../../../services/checklist/checklist_service.dart';

class TripChecklistScreen
extends StatefulWidget {
final String tripName;

const TripChecklistScreen({
super.key,
required this.tripName,
});

@override
State<TripChecklistScreen>
createState() =>
_TripChecklistScreenState();
}

class _TripChecklistScreenState
extends State<
TripChecklistScreen> {
final TextEditingController
controller =
TextEditingController();

List<Map<String, dynamic>>
items = [];

@override
void initState() {
super.initState();


items =
    ChecklistService.loadItems(
  widget.tripName,
);


}

Future<void> save() async {
await ChecklistService
.saveItems(
widget.tripName,
items,
);
}

Future<void> addItem() async {
if (controller.text.isEmpty) {
return;
}


setState(() {
  items.add({
    "title":
        controller.text,
    "done": false,
  });
});

await save();

controller.clear();


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"${widget.tripName} Checklist",
),
),
body: Column(
children: [
Padding(
padding:
const EdgeInsets.all(
16),
child: Row(
children: [
Expanded(
child: TextField(
controller:
controller,
decoration:
const InputDecoration(
hintText:
"Add item",
),
),
),
IconButton(
icon:
const Icon(
Icons.add,
),
onPressed:
addItem,
),
],
),
),
Expanded(
child:
ListView.builder(
itemCount:
items.length,
itemBuilder:
(context,
index) {
return CheckboxListTile(
title: Text(
items[index]
["title"],
),
value:
items[index]
["done"],
onChanged:
(value) async {
setState(() {
items[index]
["done"] =
value;
});


                await save();
              },
            );
          },
        ),
      ),
    ],
  ),
);


}
}
