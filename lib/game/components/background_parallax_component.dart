import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class MyParallaxComponent extends ZombieCongaGame with PanDetector {
  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData(Globals.backgroundParallaxSprite),
        // ParallaxImageData(Globals.backgroundParallaxSprite1),
        // ParallaxImageData(Globals.backgroundParallaxSprite2),
      ],
      // Repeat the image in both the x and y directions until the box is filled.
      repeat: ImageRepeat.repeat,
      // baseVelocity: Sets scrolling direction based on (x, y) where
      // x is horizontal and y is vertical. Negative goes left to right or
      // top to bottom. So (40, 0) scrolls from right to left.
      baseVelocity: Vector2(40, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );

    add(parallax);
  }
}
