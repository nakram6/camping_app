import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() =>
      _TicTacToeScreenState();
}

class _TicTacToeScreenState
    extends State<TicTacToeScreen> {
  List<String> board =
      List.filled(9, '');

  bool xTurn = true;

  String winner = '';

  void playMove(int index) {
    if (board[index].isNotEmpty ||
        winner.isNotEmpty) {
      return;
    }

    setState(() {
      board[index] =
          xTurn ? 'X' : 'O';

      xTurn = !xTurn;
    });

    checkWinner();
  }

  void checkWinner() {
    List<List<int>> wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in wins) {
      String a = board[combo[0]];
      String b = board[combo[1]];
      String c = board[combo[2]];

      if (a.isNotEmpty &&
          a == b &&
          b == c) {
        setState(() {
          winner = '$a Wins!';
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        winner = 'Draw!';
      });
    }
  }

  void resetGame() {
    setState(() {
      board =
          List.filled(9, '');

      xTurn = true;

      winner = '';
    });
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
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
              winner.isEmpty
                  ? (xTurn
                      ? 'Player X Turn'
                      : 'Player O Turn')
                  : winner,
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

            Expanded(
              child:
                  GridView.builder(
                itemCount: 9,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      3,
                ),
                itemBuilder:
                    (
                  context,
                  index,
                ) {
                  return GestureDetector(
                    onTap: () =>
                        playMove(
                      index,
                    ),
                    child:
                        Container(
                      margin:
                          const EdgeInsets.all(
                        4,
                      ),
                      decoration:
                          BoxDecoration(
                        border:
                            Border.all(),
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                      child:
                          Center(
                        child:
                            Text(
                          board[index],
                          style:
                              const TextStyle(
                            fontSize:
                                48,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton.icon(
              onPressed:
                  resetGame,
              icon: const Icon(
                Icons.refresh,
              ),
              label: const Text(
                'New Game',
              ),
            ),
          ],
        ),
      ),
    );
  }
}