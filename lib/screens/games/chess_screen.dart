import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class ChessScreen extends StatefulWidget {
  const ChessScreen({super.key});

  @override
  State<ChessScreen> createState() =>
      _ChessScreenState();
}

class _ChessScreenState
    extends State<ChessScreen> {
  final ChessBoardController controller =
      ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chess"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChessBoard(
              controller: controller,
              boardColor:
                  BoardColor.brown,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                controller.resetBoard();
              },
              icon:
                  const Icon(Icons.refresh),
              label:
                  const Text("New Game"),
            ),
          ),
        ],
      ),
    );
  }
}