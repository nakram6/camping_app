import 'package:flutter/material.dart';

import '../../services/trips/trip_service.dart';
import '../../services/members/member_service.dart';
import '../trips/members/details/member_details_screen.dart';

class AllMembersScreen
extends StatefulWidget {
const AllMembersScreen({
super.key,
});

@override
State<AllMembersScreen>
createState() =>
_AllMembersScreenState();
}

class _AllMembersScreenState
extends State<AllMembersScreen> {
List<Map<String, dynamic>>
allMembers = [];

@override
void initState() {
super.initState();


loadMembers();


}

void loadMembers() {
final trips =
TripService.loadTrips();


final List<Map<String, dynamic>>
    temp = [];

for (final trip in trips) {
  final tripName =
      trip["name"] ?? "";

  final members =
      MemberService.loadMembers(
    tripName,
  );

  for (final member
      in members) {
    temp.add({
      ...member,
      "trip":
          tripName,
    });
  }
}

setState(() {
  allMembers = temp;
});


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
"All Members",
),
backgroundColor:
Colors.green,
foregroundColor:
Colors.white,
),
body: allMembers.isEmpty
? const Center(
child: Text(
"No members found",
),
)
: ListView.builder(
itemCount:
allMembers.length,
itemBuilder:
(
context,
index,
) {
final member =
allMembers[
index];


            final isLeader =
                member[
                        "leader"] ==
                    true;

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
                    CircleAvatar(
                  backgroundColor:
                      isLeader
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
                    if (isLeader)
                      const Padding(
                        padding:
                            EdgeInsets.only(
                          left: 6,
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
                    Text(
                  "Trip: ${member["trip"]}",
                ),
                trailing:
                    const Icon(
                  Icons
                      .arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MemberDetailsScreen(
                        member:
                            member,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
);


}
}
