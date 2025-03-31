import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    required this.won,
    super.key,
  });

  final bool won;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(won ? "You Win!" : "Game Over!"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Return to the game
              },
              child: const Text("Play Again"),
            ),
          ],
        ),
      ),
    );
  }
}
