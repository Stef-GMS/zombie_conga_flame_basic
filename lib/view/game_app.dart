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
// import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
import 'package:zombie_conga_flame/view/overlay_screen.dart';
import 'package:zombie_conga_flame/view/score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  //late final BrickBreaker game;
  ////ZombieCongaGame _zombieCongaGame = ZombieCongaGame();

  @override
  void initState() {
    super.initState();
    //game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   useMaterial3: true,
      //   textTheme: GoogleFonts.pressStart2pTextTheme().apply(
      //     bodyColor: const Color(0xff184e77),
      //     displayColor: const Color(0xff184e77),
      //   ),
      // ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(
                      score: ValueNotifier(0),
                    ), //game.score),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          // construct and manage the BrickBreaker
                          // game instance
                          // child: GameWidget(
                          //   game: game,
                          //   // keys must align with the overlays that the
                          //   // playState setter in BrickBreaker added or
                          //   // removed.
                          //   overlayBuilderMap: {
                          //     PlayState.welcome.name: (context, game) => //
                          //         const OverlayScreen(
                          //           title: 'TAP TO PLAY',
                          //           subtitle: 'Use arrow keys or swipe',
                          //         ),
                          //     PlayState.gameOver.name: (context, game) => //
                          //         const OverlayScreen(
                          //           title: 'G A M E   O V E R',
                          //           subtitle: 'Tap to Play Again',
                          //         ),
                          //     PlayState.won.name: (context, game) => //
                          //         const OverlayScreen(
                          //           title: 'Y O U   W O N ! ! !',
                          //           subtitle: 'Tap to Play Again',
                          //         ),
                          //   },
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
