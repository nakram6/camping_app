import 'package:flutter/material.dart';

import '../../../services/members/member_service.dart';
import '../../../services/expenses/expense_service.dart';

import '../details/trip_details_screen.dart';
import '../members/trip_members_screen.dart';
import '../expenses/trip_expenses_screen.dart';
import '../journal/trip_journal_screen.dart';
import '../photos/trip_photos_screen.dart';

class TripDashboardScreen extends StatefulWidget {
final Map<String, String> trip;

const TripDashboardScreen({
super.key,
required this.trip,
});

@override
State<TripDashboardScreen> createState() =>
_TripDashboardScreenState();
}

class _TripDashboardScreenState
extends State<TripDashboardScreen> {
int memberCount = 0;
double totalExpenses = 0;

@override
void initState() {
super.initState();
loadData();
}

void loadData() {
final tripName =
widget.trip["name"] ?? "";


final members =
    MemberService.loadMembers(
  tripName,
);

final expenses =
    ExpenseService.loadExpenses(
  tripName,
);

double total = 0;

for (final expense in expenses) {
  total +=
      (expense["amount"] as num)
          .toDouble();
}

setState(() {
  memberCount = members.length;
  totalExpenses = total;
});


}

Widget statCard(
IconData icon,
String title,
String value,
Color color,
) {
return Card(
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
16,
),
child: Column(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
Icon(
icon,
size: 40,
color: color,
),
const SizedBox(
height: 10,
),
Text(
value,
style:
const TextStyle(
fontSize: 22,
fontWeight:
FontWeight.bold,
),
),
const SizedBox(
height: 5,
),
Text(
title,
textAlign:
TextAlign.center,
),
],
),
),
);
}

@override
Widget build(
BuildContext context) {
final trip =
widget.trip;


return Scaffold(
  backgroundColor:
      Colors.green.shade50,
  appBar: AppBar(
    title: const Text(
      "Trip Dashboard",
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
        16,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 6,
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
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    trip["name"] ??
                        "",
                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color:
                            Colors.red,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          trip["location"] ??
                              "No Location",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color:
                            Colors.blue,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          "${trip["startDate"] ?? ""} → ${trip["endDate"] ?? ""}",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  const Text(
                    "Notes",
                    style:
                        TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    trip["notes"] ??
                        "No Notes",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            "Trip Statistics",
            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          GridView.count(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              GestureDetector(
               onTap: () async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => TripMembersScreen(
        tripName: trip["name"] ?? "",
      ),
    ),
  );

  loadData();
},
                child: statCard(
                  Icons.people,
                  "Members",
                  memberCount
                      .toString(),
                  Colors.purple,
                ),
              ),

              GestureDetector(
                onTap: () async  {
               await  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TripExpensesScreen(
                        tripName:
                            trip["name"] ??
                                "",
                      ),
                    ),
                  );
                   loadData();
                },
                child: statCard(
                  Icons.attach_money,
                  "Expenses",
                  "\$${totalExpenses.toStringAsFixed(2)}",
                  Colors.green,
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TripPhotosScreen(
                        tripName:
                            trip["name"] ??
                                "",
                      ),
                    ),
                  );
                },
                child: statCard(
                  Icons.photo,
                  "Photos",
                  "Open",
                  Colors.teal,
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TripJournalScreen(
                        tripName:
                            trip["name"] ??
                                "",
                      ),
                    ),
                  );
                },
                child: statCard(
                  Icons.book,
                  "Journal",
                  "Open",
                  Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width:
                double.infinity,
            child:
                ElevatedButton.icon(
              icon:
                  const Icon(
                Icons.open_in_new,
              ),
              label:
                  const Text(
                "Open Full Trip",
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        TripDetailsScreen(
                      tripName:
                          trip["name"] ??
                              "",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
);


}
}
