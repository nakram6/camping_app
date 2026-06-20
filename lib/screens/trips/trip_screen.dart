import 'package:flutter/material.dart';

import '../../services/trips/trip_service.dart';
import 'dashboard/trip_dashboard_screen.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() =>
      _TripScreenState();
}

class _TripScreenState
    extends State<TripScreen> {
  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      locationController =
      TextEditingController();

  final TextEditingController
      startDateController =
      TextEditingController();

  final TextEditingController
      endDateController =
      TextEditingController();

  final TextEditingController
      notesController =
      TextEditingController();

  List<Map<String, String>> trips =
      [];

  @override
  void initState() {
    super.initState();

    trips =
        TripService.loadTrips();
  }

  Future<void> pickDate(
    TextEditingController
        controller,
  ) async {
    final selectedDate =
        await showDatePicker(
      context: context,
      initialDate:
          DateTime.now(),
      firstDate:
          DateTime(2020),
      lastDate:
          DateTime(2100),
    );

    if (selectedDate != null) {
      controller.text =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> addTrip() async {
    if (nameController.text
        .trim()
        .isEmpty) {
      return;
    }

    setState(() {
      trips.add({
        "name":
            nameController.text,
        "location":
            locationController.text,
        "startDate":
            startDateController
                .text,
        "endDate":
            endDateController
                .text,
        "notes":
            notesController.text,
      });
    });

    await TripService.saveTrips(
      trips,
    );

    nameController.clear();
    locationController.clear();
    startDateController.clear();
    endDateController.clear();
    notesController.clear();

    FocusScope.of(context)
        .unfocus();
  }

  Future<void> deleteTrip(
    int index,
  ) async {
    setState(() {
      trips.removeAt(index);
    });

    await TripService.saveTrips(
      trips,
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true,
      appBar: AppBar(
        title:
            const Text("Trip Planner"),
        backgroundColor:
            Colors.green,
        foregroundColor:
            Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child:
                  SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller:
                          nameController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Trip Name",
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller:
                          locationController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Location",
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller:
                          startDateController,
                      readOnly: true,
                      onTap: () =>
                          pickDate(
                        startDateController,
                      ),
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Start Date",
                        border:
                            OutlineInputBorder(),
                        suffixIcon:
                            Icon(
                          Icons
                              .calendar_month,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller:
                          endDateController,
                      readOnly: true,
                      onTap: () =>
                          pickDate(
                        endDateController,
                      ),
                      decoration:
                          const InputDecoration(
                        labelText:
                            "End Date",
                        border:
                            OutlineInputBorder(),
                        suffixIcon:
                            Icon(
                          Icons
                              .calendar_month,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller:
                          notesController,
                      maxLines: 3,
                      textInputAction:
                          TextInputAction
                              .done,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Notes",
                        border:
                            OutlineInputBorder(),
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
                            addTrip,
                        icon:
                            const Icon(
                          Icons.add,
                        ),
                        label:
                            const Text(
                          "Save Trip",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child:
                  ListView.builder(
                itemCount:
                    trips.length,
                itemBuilder:
                    (
                  context,
                  index,
                ) {
                  final trip =
                      trips[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal:
                          12,
                      vertical: 6,
                    ),
                    elevation: 4,
                    child:
                        ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TripDashboardScreen(
                              trip:
                                  trip,
                            ),
                          ),
                        );
                      },
                      leading:
                          CircleAvatar(
                        backgroundColor:
                            Colors
                                .green
                                .shade700,
                        child:
                            const Icon(
                          Icons.forest,
                          color: Colors
                              .white,
                        ),
                      ),
                      title: Text(
                        trip["name"] ??
                            "",
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      subtitle:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            trip["location"] ??
                                "",
                          ),
                          Text(
                            "${trip["startDate"]} - ${trip["endDate"]}",
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
                                deleteTrip(
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
      ),
    );
  }
}