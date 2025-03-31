import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/app/app.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/components/components.dart';
import 'package:zombie_conga_flame/game/entities/entities.dart';

import 'package:zombie_conga_flame/game/view/game_over.dart';
import 'package:zombie_conga_flame/game/view/game_over_menu.dart';
// import 'package:zombie_conga_flame/loading/view/game_over_menu.dart';

// Captures where the player is in entering, playing,
// and either losing or winning the game.
enum PlayState {
  welcome,
  playing,
  gameOver,
  won,
}

class ZombieCongaGame extends FlameGame
    with //
        HasCollisionDetection {
  ZombieCongaGame() {
    zombie = Zombie(joystick: joystick);
  }
  // : super(
  // // expose the width and height of the game so
  // // that the children components,
  // camera: CameraComponent.withFixedResolution(
  //   width: width,
  //   height: height,
  // ),
  // );

  late Zombie zombie;

  int lives = 1;
  bool gameOver = false;

  /// Text UI component for keeping track of score
  final TextComponent _catCount = // Configure TextComponent
      TextComponent(
    //text: '',  // text will be set later
    position: Vector2(5, 0),
    anchor: Anchor.topLeft,
    textRenderer: TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
        fontSize: 50,
      ),
    ),
  );

  /// Text UI component for keeping track of score
  final TextComponent _livesCount = // Configure TextComponent
      TextComponent(
    //text: '',  // text will be set later
    position: Vector2(width - 50, 0),
    anchor: Anchor.topRight,
    textRenderer: TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
        fontSize: 50,
      ),
    ),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    debugMode = true; //Flame debugMode displays boxes and circles around components to help debug

    //await FlameAudio.bgm.play(Globals.backgroundMusic);

    // Configures the top left as the anchor for the viewfinder.
    // By default, the viewfinder uses the middle of the area as
    // the anchor for (0,0).
    camera.viewfinder.anchor = Anchor.topLeft;

    print('Inside ZombieCongaGame width: $width');
    print('Inside ZombieCongaGame height: $height');

    await Flame.device.setLandscape();

    await FlameAudio.audioCache.loadAll(
      [
        Globals.hitCatSound,
        Globals.hitEnemySound,
      ],
    );

    add(MyParallaxComponent());

    add(zombie);
    add(joystick);

    if (!gameOver) {
      spawnCats();
      // spawnEnemy();

      // Add Score TextComponent.
      add(_catCount);

      // Add Score TextComponent.
      add(_livesCount);
    } else {
      GameOverMenu(
        gameRef: this,
      );
    }
  } // onLoad()

  final _random = Random();

  void spawnCats() {
    //
    // add a cat to game
    add(Cat());

    // set a timer to spawn more cats
    Timer(
      const Duration(seconds: 1) +
          Duration(
            milliseconds: _random.nextInt(1000),
          ),
      spawnCats,
    );
  }

  void spawnEnemy() {
    final enemy = CatLady();
    final x = size.x;

    final y = _random.nextDouble() * size.y;
    enemy.position = Vector2(x, y);

    add(enemy);

    enemy.add(
      MoveToEffect(
        Vector2(
          -enemy.width,
          y,
        ),
        EffectController(duration: 3.0), // SpriteKit app had 2.0
        onComplete: () {
          enemy.removeFromParent();
          spawnEnemy();
        },
      ),
    );
  }

  // dt = delta time; the time since last update

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameOver) {
      // _catCount.text = 'Cats: ${zombie.catCountInTrain()}';
      _catCount.text = 'Cats: ${zombie.catCountInTrain}';

      if (lives < 3) {
        _livesCount.textRenderer = TextPaint(
          style: TextStyle(
            color: BasicPalette.orange.color,
            fontSize: 50,
          ),
        );
      }
    } else {
      print('You Lose!');

      // FlameAudio.bgm.stop();

      removeAll(children);
      // processLifecycleEvents();
      // Flame.images.clearCache();
      // Flame.assets.clearCache();

      Navigator.of(buildContext!).push(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return const GameOver(won: false);
          },
        ),
      );
    }

    _livesCount
      ..text = 'Lives: $lives'
      ..position = Vector2(width - 20.0, 0);

    return;
  }

  void reset() {
    // example of using a function
    // zombie.removeCatsFromTrain(zombie.catCountInTrain());

    // example of using a getter
    zombie.removeCatsFromTrain(zombie.catCountInTrain);

    // example of using a setter to set a zombie property
    //zombie.catCountInTrain = 100;
  }

  @override
  void onRemove() {
    // // Optional based on your game needs.
    //removeAll(children);
    processLifecycleEvents();
    Flame.images.clearCache();
    Flame.assets.clearCache();
    // // Any other code that you want to run when the game is removed.
  }

  void catCollidesWithZombie() {
    add(Cat());
  }

  void enemyCollidesWithZombie() {
    zombie
      ..removeCatsFromTrain(2)
      ..makeInvincible();

    lives--;
    print('Lives: $lives');

    if (lives <= 1) {
      gameOver = true;
    }
  }
} // ZombieCongaGame
