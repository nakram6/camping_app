import 'package:flutter/material.dart';

class CampfireTriviaScreen
    extends StatefulWidget {
  const CampfireTriviaScreen({
    super.key,
  });

  @override
  State<CampfireTriviaScreen>
      createState() =>
          _CampfireTriviaScreenState();
}

class _CampfireTriviaScreenState
    extends State<
        CampfireTriviaScreen> {
  final List<Map<String, dynamic>>
      questions = [
    {
      "question":
          "Which animal is known as the King of the Jungle?",
      "answers": [
        "Lion",
        "Tiger",
        "Bear",
        "Wolf"
      ],
      "correct": "Lion"
    },
    {
      "question":
          "How many legs does a spider have?",
      "answers": [
        "6",
        "8",
        "10",
        "12"
      ],
      "correct": "8"
    },
    {
      "question":
          "Which planet is known as the Red Planet?",
      "answers": [
        "Earth",
        "Mars",
        "Venus",
        "Jupiter"
      ],
      "correct": "Mars"
    },
    {
      "question":
          "What do bees make?",
      "answers": [
        "Milk",
        "Honey",
        "Bread",
        "Cheese"
      ],
      "correct": "Honey"
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  bool answered = false;

  void answerQuestion(
    String answer,
  ) {
    if (answered) return;

    answered = true;

    if (answer ==
        questions[currentQuestion]
            ["correct"]) {
      score++;
    }

    setState(() {});
  }

  void nextQuestion() {
    if (currentQuestion <
        questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
          title: const Text(
            "Quiz Finished",
          ),
          content: Text(
            "Your Score: $score / ${questions.length}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);

                setState(() {
                  currentQuestion = 0;
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
    final question =
        questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Campfire Trivia",
        ),
        backgroundColor:
            Colors.orange,
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
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              question["question"],
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ...(question["answers"]
                    as List<String>)
                .map(
              (answer) =>
                  Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child:
                      ElevatedButton(
                    onPressed:
                        () =>
                            answerQuestion(
                      answer,
                    ),
                    child:
                        Text(answer),
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
                "Next Question",
              ),
            ),
          ],
        ),
      ),
    );
  }
}