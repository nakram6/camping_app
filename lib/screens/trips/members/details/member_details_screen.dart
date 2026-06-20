import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberDetailsScreen
extends StatelessWidget {
final Map<String, dynamic> member;

const MemberDetailsScreen({
super.key,
required this.member,
});

Future<void> callMember() async {
final phone =
member["phone"] ?? "";


if (phone.isEmpty) return;

final uri = Uri.parse(
  'tel:$phone',
);

await launchUrl(uri);


}

Future<void> emailMember() async {
final email =
member["email"] ?? "";


if (email.isEmpty) return;

final uri = Uri.parse(
  'mailto:$email',
);

await launchUrl(uri);


}

@override
Widget build(
BuildContext context) {
final isLeader =
member["leader"] == true;


return Scaffold(
  backgroundColor:
      Colors.green.shade50,
  appBar: AppBar(
    title: const Text(
      "Member Details",
    ),
    backgroundColor:
        Colors.green,
    foregroundColor:
        Colors.white,
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding:
          const EdgeInsets.all(
        20,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor:
                isLeader
                    ? Colors.orange
                    : Colors.green,
            child: const Icon(
              Icons.person,
              size: 60,
              color:
                  Colors.white,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              Text(
                member["name"] ??
                    "",
                style:
                    const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              if (isLeader)
                const Padding(
                  padding:
                      EdgeInsets.only(
                    left: 8,
                  ),
                  child: Icon(
                    Icons.star,
                    color: Colors
                        .orange,
                  ),
                ),
            ],
          ),

          const SizedBox(
            height: 25,
          ),

          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(
                20,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        const Icon(
                      Icons.phone,
                      color:
                          Colors.green,
                    ),
                    title:
                        const Text(
                      "Phone",
                    ),
                    subtitle:
                        Text(
                      member["phone"] ??
                          "",
                    ),
                  ),

                  const Divider(),

                  ListTile(
                    leading:
                        const Icon(
                      Icons.email,
                      color:
                          Colors.blue,
                    ),
                    title:
                        const Text(
                      "Email",
                    ),
                    subtitle:
                        Text(
                      member["email"] ??
                          "",
                    ),
                  ),

                  const Divider(),

                  ListTile(
                    leading:
                        const Icon(
                      Icons.flag,
                      color:
                          Colors.orange,
                    ),
                    title:
                        const Text(
                      "Role",
                    ),
                    subtitle:
                        Text(
                      isLeader
                          ? "Trip Leader"
                          : "Member",
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          SizedBox(
            width:
                double.infinity,
            child:
                ElevatedButton.icon(
              onPressed:
                  callMember,
              icon:
                  const Icon(
                Icons.call,
              ),
              label:
                  const Text(
                "Call Member",
              ),
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
                  emailMember,
              icon:
                  const Icon(
                Icons.email,
              ),
              label:
                  const Text(
                "Email Member",
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Card(
            color:
                Colors.blue.shade50,
            child: const Padding(
              padding:
                  EdgeInsets.all(
                16,
              ),
              child: Column(
                children: [
                  Text(
                    "Future Features",
                    style:
                        TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "📍 Live Location\n🔋 Battery Status\n📸 Shared Photos\n💬 Trip Chat",
                    textAlign:
                        TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);


}
}
