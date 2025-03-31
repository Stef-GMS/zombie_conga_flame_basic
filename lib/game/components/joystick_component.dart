import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

final JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 20,
    paint: BasicPalette.orange.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 60,
    paint: BasicPalette.orange.withAlpha(100).paint(),
  ),
  margin: const EdgeInsets.only(
    left: 40,
    bottom: 40,
  ),
);
