import 'package:flutter/material.dart';

class SurvivalQuizScreen
    extends StatefulWidget {
  const SurvivalQuizScreen({
    super.key,
  });

  @override
  State<SurvivalQuizScreen>
      createState() =>
          _SurvivalQuizScreenState();
}

class _SurvivalQuizScreenState
    extends State<
        SurvivalQuizScreen> {
  final List<Map<String, dynamic>>
      questions = [
    {
      "question":
          "If you get lost while hiking, what should you do first?",
      "answers": [
        "Run around",
        "Stay calm",
        "Hide",
        "Keep walking"
      ],
      "correct": "Stay calm"
    },
    {
      "question":
          "What is the safest water to drink in the wilderness?",
      "answers": [
        "River water",
        "Lake water",
        "Boiled water",
        "Pond water"
      ],
      "correct": "Boiled water"
    },
    {
      "question":
          "Which direction does a compass needle point?",
      "answers": [
        "South",
        "East",
        "North",
        "West"
      ],
      "correct": "North"
    },
    {
      "question":
          "What should you do if you encounter a bear?",
      "answers": [
        "Run away",
        "Climb a tree",
        "Stay calm and back away",
        "Throw rocks"
      ],
      "correct":
          "Stay calm and back away"
    },
    {
      "question":
          "How many days can most people survive without water?",
      "answers": [
        "1 Day",
        "3 Days",
        "10 Days",
        "30 Days"
      ],
      "correct": "3 Days"
    },
  ];

  int current = 0;
  int score = 0;
  bool answered = false;

  void answer(String choice) {
    if (answered) return;

    answered = true;

    if (choice ==
        questions[current]
            ["correct"]) {
      score++;
    }

    setState(() {});
  }

  void nextQuestion() {
    if (current <
        questions.length - 1) {
      setState(() {
        current++;
        answered = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
          title: const Text(
            "Quiz Complete",
          ),
          content: Text(
            "You scored $score / ${questions.length}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);

                setState(() {
                  current = 0;
                  score = 0;
                  answered = false;
                });
              },
              child: const Text(
                "Play Again",
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(
      BuildContext context) {
    final q =
        questions[current];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Survival Quiz",
        ),
        backgroundColor:
            Colors.green,
        foregroundColor:
            Colors.white,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            Text(
              "Score: $score",
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              q["question"],
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            ...(q["answers"]
                    as List<String>)
                .map(
              (answerChoice) =>
                  Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: SizedBox(
                  width:
                      double.infinity,
                  child:
                      ElevatedButton(
                    onPressed:
                        () =>
                            answer(
                      answerChoice,
                    ),
                    child: Text(
                      answerChoice,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed:
                  answered
                      ? nextQuestion
                      : null,
              child: const Text(
                "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}