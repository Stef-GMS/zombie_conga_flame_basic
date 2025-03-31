import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({
    required this.gameRef,
    super.key,
  });
  static const String id = 'GameOverMenu';
  final ZombieCongaGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${Globals.mainMenuSprite}'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'Game Over',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'Score: ${gameRef.zombie.catCountInTrain}',
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(GameOverMenu.id);
                      gameRef
                        ..reset()
                        ..resumeEngine();
                    },
                    child: const Text(
                      'Play Again?',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(GameOverMenu.id);
                      gameRef
                        ..reset()
                        ..resumeEngine();
                    },
                    child: const Text(
                      'Main Menu',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
