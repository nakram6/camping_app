import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/storage/emergency_service.dart';

class EmergencyScreen extends StatefulWidget {
const EmergencyScreen({super.key});

@override
State<EmergencyScreen> createState() =>
_EmergencyScreenState();
}

class _EmergencyScreenState
extends State<EmergencyScreen> {
final TextEditingController
nameController =
TextEditingController();

final TextEditingController
phoneController =
TextEditingController();

List<Map<String, String>>
contacts = [];

@override
void initState() {
super.initState();


contacts =
    EmergencyService.loadContacts();


}

Future<void> addContact() async {
if (nameController.text.isEmpty ||
phoneController.text.isEmpty) {
return;
}


setState(() {
  contacts.add({
    "name":
        nameController.text,
    "phone":
        phoneController.text,
  });
});

await EmergencyService
    .saveContacts(
  contacts,
);

nameController.clear();
phoneController.clear();


}

Future<void> deleteContact(
int index) async {
setState(() {
contacts.removeAt(index);
});


await EmergencyService
    .saveContacts(
  contacts,
);


}

Future<void> callNumber(
String phone,
) async {
final uri =
Uri.parse('tel:$phone');


if (await canLaunchUrl(
  uri,
)) {
  await launchUrl(uri);
}


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
"Emergency Contacts",
),
backgroundColor:
Colors.red,
foregroundColor:
Colors.white,
),
body: Column(
children: [
Card(
margin:
const EdgeInsets.all(
12),
color:
Colors.red.shade50,
child: ListTile(
leading: const Icon(
Icons.local_hospital,
color: Colors.red,
),
title: const Text(
"Emergency Services",
),
subtitle: const Text(
"911",
),
trailing:
IconButton(
icon: const Icon(
Icons.call,
color:
Colors.green,
),
onPressed: () =>
callNumber(
"911",
),
),
),
),


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
                    "Contact Name",
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
                    "Phone Number",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton.icon(
                onPressed:
                    addContact,
                icon: const Icon(
                  Icons.add,
                ),
                label: const Text(
                  "Add Contact",
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
              contacts.length,
          itemBuilder:
              (context,
                  index) {
            final contact =
                contacts[
                    index];

            return Card(
              margin:
                  const EdgeInsets.symmetric(
                horizontal:
                    12,
                vertical: 6,
              ),
              child:
                  ListTile(
                leading:
                    const CircleAvatar(
                  backgroundColor:
                      Colors.red,
                  child: Icon(
                    Icons.person,
                    color: Colors
                        .white,
                  ),
                ),
                title: Text(
                  contact[
                          "name"] ??
                      "",
                ),
                subtitle:
                    Text(
                  contact[
                          "phone"] ??
                      "",
                ),
                trailing:
                    Row(
                  mainAxisSize:
                      MainAxisSize
                          .min,
                  children: [
                    IconButton(
                      icon:
                          const Icon(
                        Icons.call,
                        color:
                            Colors.green,
                      ),
                      onPressed:
                          () =>
                              callNumber(
                        contact[
                                "phone"] ??
                            "",
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(
                        Icons.delete,
                        color:
                            Colors.red,
                      ),
                      onPressed:
                          () =>
                              deleteContact(
                        index,
                      ),
                    ),
                  ],
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
