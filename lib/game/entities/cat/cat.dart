import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/effects.dart';
//import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/entities/zombie/zombie.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class Cat extends SpriteComponent //
    with
        HasGameRef<ZombieCongaGame>,
        CollisionCallbacks {
  final double _spriteWidth = 146;
  final double _spriteHeight = 156;

  final Random _random = Random();

  bool captured = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.catSprite);
    width = _spriteWidth / 2.5;
    height = _spriteHeight / 2.5;

    // print('cat _spriteWidth: $_spriteWidth');
    // print('cat _spriteHeight: $_spriteHeight');
    //
    // print('cat width: $width');
    // print('cat height: $height');

    position = _getCatRandomPosition();
    anchor = Anchor.centerRight;

    add(CircleHitbox());

    scale = Vector2.zero();
    angle = -pi / 16;
    final appear = Vector2.all(1.0);
    const leftWiggle = pi / 8;
    const rightWiggle = -pi / 8;
    final scaleUp = Vector2.all(1.2);
    final scaleDown = Vector2.all(1.0);
    final actions = [
      ScaleEffect.to(appear, EffectController(duration: 0.5)),
      RotateEffect.by(leftWiggle, EffectController(duration: 0.5)),
      RotateEffect.by(rightWiggle, EffectController(duration: 0.5)),
      ScaleEffect.to(scaleUp, EffectController(duration: 0.25)),
      ScaleEffect.to(scaleDown, EffectController(duration: 0.25)),
      ScaleEffect.to(scaleUp, EffectController(duration: 0.25)),
      ScaleEffect.to(scaleDown, EffectController(duration: 0.25)),
      RotateEffect.by(leftWiggle, EffectController(duration: 0.5)),
      RotateEffect.by(rightWiggle, EffectController(duration: 0.5)),
    ];

    final sequence = SequenceEffect(
      actions,
      //EffectController(duration: 5.0),
    );

    add(sequence);

    Timer(
      Duration(milliseconds: Random().nextInt(3000) + 5000),
      removeCat,
    );
  }

  void removeCat() {
    if (!captured) {
      removeFromParent();
    }
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   if (!captured) {
  //     // move cat here
  //   }
  // }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (captured) {
      return;
    }

    if (other is Zombie) {
      //
      // Add Cat Train behind Zombie
      other.addCatToTrain(this);
      gameRef.catCollidesWithZombie();
      captured = true;

      //
      FlameAudio.play(Globals.hitCatSound);

      // When Zombie hits cat, turn Cat green.
      // colorFilter has a built-in shader, so don't need to create a Shader
      getPaint().colorFilter = const ColorFilter.mode(
        Color.from(alpha: 1.0, red: 0.0, green: 1.0, blue: 0.0),
        BlendMode.modulate,
      );
    }

    super.onCollision(intersectionPoints, other);
  }

  Vector2 _getCatRandomPosition() {
    final x = _random.nextDouble() * gameRef.size.x;
    final y = _random.nextDouble() * gameRef.size.y;
    return Vector2(x, y);
  }
}
