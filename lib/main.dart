import 'dart:io';

import 'package:flutter/material.dart';

import 'package:window_manager/window_manager.dart';
import 'package:zombie_conga_flame/app/app.dart';
import 'package:zombie_conga_flame/constants/globals.dart';

void main() async {
  // Check to see if device is Desktop and if so then set window sizes and title
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    await windowManager.setMinimumSize(const Size(1024, 578)); // 768 doesn't give 16/9 ratio
    await windowManager.setMaximumSize(const Size(2048, 1156)); // 1536 doesn't give 16/9 ratio
    await windowManager.setSize(const Size(1024, 578)); // 768 doesn't give 16/9 ratio
    await windowManager.setAspectRatio(16.0 / 9.0); // aspect ratio supported, 16:9 (1.77)
    await windowManager.setMaximizable(false);

    await windowManager.setTitle('Zombie Conga'); //Window title
  }

  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine size of screen

    // Get width of device.  Use longestSide for landscape apps, shortestSide for portrait.
    gameWidth = MediaQuery.of(context).size.longestSide;

    // Get height device.  Use shortestSide for landscape apps, longestSide for portrait.
    gameHeight = MediaQuery.of(context).size.shortestSide;

    // Set deviceSize based on width.  This is used for font scaling.
    deviceSize = gameWidth >= 1024
        ? 'extra large'
        : gameWidth >= 700
            ? 'large'
            : gameWidth > 380
                ? 'medium'
                : 'small';

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
