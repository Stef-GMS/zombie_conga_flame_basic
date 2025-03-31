import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

// import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
// import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
import 'package:zombie_conga_flame/game/view/overlay_screen.dart';
import 'package:zombie_conga_flame/game/view/score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final ZombieCongaGame game;
  ZombieCongaGame _zombieCongaGame = ZombieCongaGame();

  @override
  void initState() {
    super.initState();
    game = _zombieCongaGame;
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      // keys must align with the overlays that the
      // playState setter in BrickBreaker added or
      // removed.
      overlayBuilderMap: {
        PlayState.welcome.name: (context, game) => //
            const OverlayScreen(
              title: 'TAP TO PLAY',
              subtitle: 'Use arrow keys or swipe',
            ),
        PlayState.gameOver.name: (context, game) => //
            const OverlayScreen(
              title: 'G A M E   O V E R',
              subtitle: 'Tap to Play Again',
            ),
        PlayState.won.name: (context, game) => //
            const OverlayScreen(
              title: 'Y O U   W O N ! ! !',
              subtitle: 'Tap to Play Again',
            ),
      },
    );
  }
}
