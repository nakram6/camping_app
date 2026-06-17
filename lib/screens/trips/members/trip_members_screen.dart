import 'package:flutter/material.dart';

import '../../../services/members/member_service.dart';

class TripMembersScreen
extends StatefulWidget {
final String tripName;

const TripMembersScreen({
super.key,
required this.tripName,
});

@override
State<TripMembersScreen>
createState() =>
_TripMembersScreenState();
}

class _TripMembersScreenState
extends State<
TripMembersScreen> {
final TextEditingController
controller =
TextEditingController();

List<String> members = [];

@override
void initState() {
super.initState();


members =
    MemberService.loadMembers(
  widget.tripName,
);


}

Future<void> save() async {
await MemberService.saveMembers(
widget.tripName,
members,
);
}

Future<void> addMember() async {
if (controller.text.isEmpty) {
return;
}


setState(() {
  members.add(
    controller.text,
  );
});

await save();

controller.clear();

}

Future<void> removeMember(
int index,
) async {
setState(() {
members.removeAt(index);
});


await save();


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
"${widget.tripName} Members",
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
"Add member",
),
),
),
IconButton(
icon:
const Icon(
Icons.add,
),
onPressed:
addMember,
),
],
),
),
Expanded(
child:
ListView.builder(
itemCount:
members.length,
itemBuilder:
(context,
index) {
return ListTile(
leading:
const CircleAvatar(
child: Icon(
Icons.person,
),
),
title: Text(
members[index],
),
trailing:
IconButton(
icon:
const Icon(
Icons.delete,
color:
Colors.red,
),
onPressed:
() =>
removeMember(
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
