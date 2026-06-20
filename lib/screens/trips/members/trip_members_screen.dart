import 'package:flutter/material.dart';

import '../../../services/members/member_service.dart';

import 'details/member_details_screen.dart';
class TripMembersScreen extends StatefulWidget {
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
extends State<TripMembersScreen> {
final TextEditingController
nameController =
TextEditingController();

final TextEditingController
phoneController =
TextEditingController();

final TextEditingController
emailController =
TextEditingController();

bool isLeader = false;

List<Map<String, dynamic>>
members = [];

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
if (nameController.text
.trim()
.isEmpty) {
return;
}


setState(() {
  members.add({
    "name":
        nameController.text,
    "phone":
        phoneController.text,
    "email":
        emailController.text,
    "leader":
        isLeader,
  });
});

await save();

nameController.clear();
phoneController.clear();
emailController.clear();

setState(() {
  isLeader = false;
});


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
backgroundColor:
Colors.green,
foregroundColor:
Colors.white,
),
body: Column(
children: [
Padding(
padding:
const EdgeInsets.all(
16),
child: Column(
children: [
TextField(
controller:
nameController,
decoration:
const InputDecoration(
labelText:
"Name",
border:
OutlineInputBorder(),
),
),


            const SizedBox(
              height: 10,
            ),

            TextField(
              controller:
                  phoneController,
              keyboardType:
                  TextInputType
                      .phone,
              decoration:
                  const InputDecoration(
                labelText:
                    "Phone",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              controller:
                  emailController,
              keyboardType:
                  TextInputType
                      .emailAddress,
              decoration:
                  const InputDecoration(
                labelText:
                    "Email",
                border:
                    OutlineInputBorder(),
              ),
            ),

            CheckboxListTile(
              value:
                  isLeader,
              title:
                  const Text(
                "Trip Leader",
              ),
              onChanged:
                  (value) {
                setState(() {
                  isLeader =
                      value ??
                          false;
                });
              },
            ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton.icon(
                onPressed:
                    addMember,
                icon:
                    const Icon(
                  Icons.add,
                ),
                label:
                    const Text(
                  "Add Member",
                ),
              ),
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
              (
            context,
            index,
          ) {
            final member =
                members[
                    index];

            return Card(
              margin:
                  const EdgeInsets.symmetric(
                horizontal:
                    12,
                vertical:
                    6,
              ),
              child:
                  ListTile(
                leading:
                    CircleAvatar(
                  backgroundColor:
                      member["leader"] ==
                              true
                          ? Colors
                              .orange
                          : Colors
                              .green,
                  child:
                      const Icon(
                    Icons
                        .person,
                    color: Colors
                        .white,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      member["name"] ??
                          "",
                    ),
                    if (member[
                            "leader"] ==
                        true)
                      const Padding(
                        padding:
                            EdgeInsets.only(
                          left:
                              6,
                        ),
                        child:
                            Icon(
                          Icons
                              .star,
                          color: Colors
                              .orange,
                          size:
                              18,
                        ),
                      ),
                  ],
                ),
                subtitle:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    if ((member["phone"] ??
                            "")
                        .isNotEmpty)
                      Text(
                        "📞 ${member["phone"]}",
                      ),
                    if ((member["email"] ??
                            "")
                        .isNotEmpty)
                      Text(
                        "📧 ${member["email"]}",
                      ),
                  ],
                ),
                trailing:
                    IconButton(
                  icon:
                      const Icon(
                    Icons
                        .delete,
                    color:
                        Colors.red,
                  ),
                  onPressed:
                      () =>
                          removeMember(
                    index,
                  ),
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
