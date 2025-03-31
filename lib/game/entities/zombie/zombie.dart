import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/entities/cat/cat.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

enum MovementState {
  idle,
  move1,
  move2,
  move3,
}

class Zombie extends SpriteGroupComponent<MovementState>
    with //
        HasGameRef<ZombieCongaGame>,
        DragCallbacks {
  Zombie({
    required this.joystick,
  });

  /// Zombie height and width
  final double _spriteWidth = 314;
  final double _spriteHeight = 204;

  /// Max speed Zombie will move
  final double _speed = 350; //250;

  final train = <Cat>[];

  /// Device boundaries
  late double _leftBound;
  late double _rightBound;
  late double _upBound;
  late double _downBound;

  /// Joystick for moving Zombie
  JoystickComponent joystick;

  bool isInvincible = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Sprites
    final zombieIdle = await gameRef.loadSprite(Globals.zombieIdle);
    final zombieMove1 = await gameRef.loadSprite(Globals.zombieMove1);
    final zombieMove2 = await gameRef.loadSprite(Globals.zombieMove2);
    final zombieMove3 = await gameRef.loadSprite(Globals.zombieMove3);

    // Sprite states
    sprites = {
      MovementState.idle: zombieIdle,
      MovementState.move1: zombieMove1,
      MovementState.move2: zombieMove2,
      MovementState.move3: zombieMove3,
    };

    // Set boundaries
    _rightBound = gameRef.size.x - 45;
    _leftBound = 0 + 45;
    _upBound = 0 + 46;
    _downBound = gameRef.size.y - 46; //85;

    current = MovementState.idle;

    // Set position to middle of screen
    position = gameRef.size / 2.0;

    // Set sprite dimensions for screen
    height = _spriteHeight / 2.5;
    width = _spriteWidth / 2.5;
    anchor = Anchor.centerLeft;

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updatePosition(dt);
    _updateTrain(dt);
  }

  void _updatePosition(double dt) {
    // Set joystick direction and how much to move based on direction
    if (joystick.direction == JoystickDirection.idle) {
      current = MovementState.idle;
      return;
    }
    if (x >= _rightBound) {
      x = _rightBound - 1;
    }

    if (x <= _leftBound) {
      x = _leftBound + 1;
    }

    if (y <= _upBound) {
      y = _upBound + 1;
    }

    if (y >= _downBound) {
      y = _downBound - 1;
    }

    final movingLeft = joystick.relativeDelta[0] < 0;

    if (movingLeft) {
      current = MovementState.move1;
    } else {
      current = MovementState.move2;
    }

    position += joystick.relativeDelta * _speed * dt;
  }

  void _updateTrain(double dt) {
    final offset = Vector2(-20.0, 0.0);
    const actionDuration = 0.3;
    const catMovePointsPerSec = 210.0;

    var targetPosition = position + offset;

    for (final cat in train) {
      //
      // Check to see if the cat has any children (other cats in the train)
      if (cat.children.any((component) => component is MoveByEffect) == false) {
        //
        // Set the direction the cat needs to move
        final direction = (targetPosition - cat.position).normalized();

        // Set the position delta the cat needs to move
        final deltaPos =
            direction * catMovePointsPerSec * actionDuration; // n = pixels per sec; ex. n = 100.0

        // Add cat to train
        cat.add(
          MoveByEffect(
            deltaPos,
            EffectController(duration: actionDuration),
          ),
        );
      }

      // Set the position for cat in relation to Zombie train of cats
      targetPosition = cat.position + offset;
    }
  }

  void removeCatsFromTrain(int count) {
    for (var i = 0; i < count && train.isNotEmpty; i++) {
      train.removeLast().removeFromParent();
    }
  }

  // if you have parameters then you must use function
  // int getCatCountInTrain() => train.length;

  // since there are no parameters, use a property by using a "getter"
  // if you need to do multiple steps then use a function not a getter
  // getter should not have side effects that change state or
  int get catCountInTrain => train.length;

  //set catCountInTrain(int value){}

  void addCatToTrain(Cat cat) {
    train.add(cat);
  }

  void makeInvincible() {
    if (isInvincible) {
      return;
    }

    isInvincible = true;

    Timer(
      const Duration(seconds: 3),
      () {
        isInvincible = false;
      },
    );
  }
}
