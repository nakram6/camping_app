import 'dart:math';
import 'package:flutter/material.dart';

class CharadesScreen extends StatefulWidget {
  const CharadesScreen({super.key});

  @override
  State<CharadesScreen> createState() =>
      _CharadesScreenState();
}

class _CharadesScreenState
    extends State<CharadesScreen> {
  final List<String> prompts = [
    "Lion",
    "Elephant",
    "Camping",
    "Fishing",
    "Dentist",
    "Doctor",
    "Basketball",
    "Soccer",
    "Airplane",
    "Bicycle",
    "Firefighter",
    "Teacher",
    "Cat",
    "Dog",
    "Monkey",
    "Pizza",
    "Hamburger",
    "Superhero",
    "Spider",
    "Robot",
    "Photographer",
    "Mountain",
    "Swimming",
    "Hiking",
    "Tent",
  ];

  String currentPrompt =
      "Tap Generate";

  void generatePrompt() {
    final random = Random();

    setState(() {
      currentPrompt =
          prompts[random.nextInt(
        prompts.length,
      )];
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Charades"),
        backgroundColor:
            Colors.purple,
        foregroundColor:
            Colors.white,
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(
            24,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Text(
                "Act This Out",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    32,
                  ),
                  child: Text(
                    currentPrompt,
                    textAlign:
                        TextAlign.center,
                    style:
                        const TextStyle(
                      fontSize: 36,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              ElevatedButton.icon(
                onPressed:
                    generatePrompt,
                icon: const Icon(
                  Icons.refresh,
                ),
                label: const Text(
                  "Generate",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}