import 'package:flutter/material.dart';

import 'tic_tac_toe_screen.dart';
import 'campfire_trivia_screen.dart';
import 'chess_screen.dart';
import 'charades_screen.dart';


class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Games"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _gameCard(
              context,
              "Chess",
              Icons.sports_esports,
              Colors.brown,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ChessScreen(),
                  ),
                );
              },
            ),

            _gameCard(
              context,
              "Tic Tac Toe",
              Icons.grid_3x3,
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const TicTacToeScreen(),
                  ),
                );
              },
            ),

            _gameCard(
              context,
              "Charades",
              Icons.theater_comedy,
              Colors.purple,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CharadesScreen(),
                  ),
                );
              },
            ),

            _gameCard(
              context,
              "Campfire Trivia",
              Icons.local_fire_department,
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CampfireTriviaScreen(),
                  ),
                );
              },
            ),

            _gameCard(
              context,
              "Ludo",
              Icons.casino,
              Colors.blue,
              () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Coming Soon",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(20),
      child: Card(
        elevation: 6,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor:
                  color.withOpacity(
                0.15,
              ),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              textAlign:
                  TextAlign.center,
              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

