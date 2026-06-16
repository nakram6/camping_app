import 'package:flutter/material.dart';

import '../../services/storage/checklist_service.dart';

class ChecklistScreen extends StatefulWidget {
const ChecklistScreen({super.key});

@override
State<ChecklistScreen> createState() =>
_ChecklistScreenState();
}

class _ChecklistScreenState
extends State<ChecklistScreen> {
final TextEditingController controller =
TextEditingController();

List<String> items = [];

@override
void initState() {
super.initState();


items =
    ChecklistService.getItems();


}

Future<void> addItem() async {
if (controller.text.isEmpty) return;


setState(() {
  items.add(
    controller.text,
  );
});

await ChecklistService.saveItems(
  items,
);

controller.clear();


}

Future<void> deleteItem(
int index) async {
setState(() {
items.removeAt(index);
});


await ChecklistService.saveItems(
  items,
);


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title:
const Text("Checklist"),
),
body: Column(
children: [
Padding(
padding:
const EdgeInsets.all(
12),
child: Row(
children: [
Expanded(
child: TextField(
controller:
controller,
decoration:
const InputDecoration(
hintText:
"Add item...",
),
),
),
IconButton(
onPressed:
addItem,
icon: const Icon(
Icons.add,
),
),
],
),
),


      Expanded(
        child: ListView.builder(
          itemCount:
              items.length,
          itemBuilder:
              (context, index) {
            return ListTile(
              title: Text(
                items[index],
              ),
              trailing:
                  IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () =>
                    deleteItem(
                  index,
                ),
              ),
            );
          },
        ),
      ),
    ],
  ),
);


}
}
