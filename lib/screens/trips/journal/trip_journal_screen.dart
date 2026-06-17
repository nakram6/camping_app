import 'package:flutter/material.dart';

import '../../../services/journal/journal_service.dart';

class TripJournalScreen
extends StatefulWidget {
final String tripName;

const TripJournalScreen({
super.key,
required this.tripName,
});

@override
State<TripJournalScreen>
createState() =>
_TripJournalScreenState();
}

class _TripJournalScreenState
extends State<
TripJournalScreen> {
final TextEditingController
controller =
TextEditingController();

@override
void initState() {
super.initState();


controller.text =
    JournalService.loadJournal(
  widget.tripName,
);


}

Future<void> saveJournal()
async {
await JournalService
.saveJournal(
widget.tripName,
controller.text,
);


ScaffoldMessenger.of(
  context,
).showSnackBar(
  const SnackBar(
    content:
        Text("Journal Saved"),
  ),
);


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"${widget.tripName} Journal",
),
),
body: Padding(
padding:
const EdgeInsets.all(
16),
child: Column(
children: [
Expanded(
child: TextField(
controller:
controller,
maxLines: null,
expands: true,
decoration:
const InputDecoration(
hintText:
"Write your trip notes here...",
border:
OutlineInputBorder(),
),
),
),


        const SizedBox(
          height: 12,
        ),

        SizedBox(
          width:
              double.infinity,
          child:
              ElevatedButton.icon(
            onPressed:
                saveJournal,
            icon:
                const Icon(
              Icons.save,
            ),
            label:
                const Text(
              "Save Journal",
            ),
          ),
        ),
      ],
    ),
  ),
);


}
}
