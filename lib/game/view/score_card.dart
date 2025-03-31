import 'package:flutter/material.dart';
import 'package:flame/palette.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    const _gapHeight = SizedBox(height: 10);
    const _gapWidth = SizedBox(width: 10);

    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (
        context,
        score,
        child,
      ) {
        return Row(
          children: [
            Column(
              children: [
                Text(
                  'Cats: $score'.toUpperCase(),
                  style: TextStyle(
                    color: BasicPalette.orange.color,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            Expanded(child: _gapWidth),
            Column(
              children: [
                Text(
                  'Lives: 10,000'.toUpperCase(),
                  style: TextStyle(
                    color: BasicPalette.orange.color,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
