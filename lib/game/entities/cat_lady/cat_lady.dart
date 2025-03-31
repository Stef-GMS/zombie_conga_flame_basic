import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/entities/zombie/zombie.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class CatLady extends SpriteComponent //
    with
        HasGameRef<ZombieCongaGame>,
        CollisionCallbacks {
  CatLady() {
    width = _spriteWidth / 2.5;
    height = _spriteHeight / 2.5;
  }
  final double _spriteWidth = 232;
  final double _spriteHeight = 322;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.enemySprite);
    anchor = Anchor.centerLeft; //sprite's center left

    // print('In Enemy.dart - Enemy position $position');

    add(CircleHitbox());
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Zombie) {
      if (other.isInvincible == false) {
        gameRef.enemyCollidesWithZombie();

        FlameAudio.play(Globals.hitEnemySound);
      }
    }

    super.onCollision(intersectionPoints, other);
  }
}
