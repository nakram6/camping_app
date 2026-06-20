import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ludo/gameengine/model/game_state.dart';
import 'ludo/gameengine/model/dice_model.dart';
import 'ludo/widgets/gameplay.dart';
import 'ludo/widgets/dice.dart';

class LudoScreen extends StatelessWidget {
  const LudoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameState(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiceModel(),
        ),
      ],
      child: const _LudoHome(),
    );
  }
}

class _LudoHome extends StatelessWidget {
  const _LudoHome();

  @override
  Widget build(BuildContext context) {
    final gameState =
        Provider.of<GameState>(context);

    final GlobalKey keyBar =
        GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ludo"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: GamePlay(
        keyBar,
        gameState,
      ),
      floatingActionButton:
          Dice(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerDocked,
      bottomNavigationBar:
          const BottomAppBar(
        child: SizedBox(
          height: 50,
        ),
      ),
    );
  }
}