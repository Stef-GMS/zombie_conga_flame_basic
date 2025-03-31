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

    // await windowManager.setMinimumSize(const Size(1024, 768));
    // await windowManager.setMaximumSize(const Size(2048, 1536));
    // await windowManager.setSize(const Size(1024, 768));

    // await windowManager.setMinimumSize(const Size(1024, 578)); // 768 doesn't give 16/9 ratio
    // await windowManager.setMaximumSize(const Size(2048, 1156)); // 1536 doesn't give 16/9 ratio
    // await windowManager.setSize(const Size(1024, 578)); // 768 doesn't give 16/9 ratio

    await windowManager.setMinimumSize(Size(width / 2, height / 2));
    await windowManager.setMaximumSize(Size(width, height));
    await windowManager.setSize(Size(width / 2, height / 2));

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

    // // Get width of device.  Use longestSide for landscape apps, shortestSide for portrait.
    width = MediaQuery.of(context).size.longestSide;
    // print('Inside MainApp() Build() - width: $width');
    //
    // // Get height device.  Use shortestSide for landscape apps, longestSide for portrait.
    height = MediaQuery.of(context).size.shortestSide;
    // print('Inside MainApp() Build() - height: $height');

    // // To help with font scaling, set deviceSize based on width.
    // deviceSize = width >= 1024
    //     ? 'extra large'
    //     : width >= 700
    //         ? 'large'
    //         : width > 380
    //             ? 'medium'
    //             : 'small';

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: App(),
        ),
      ),
    );
  }
}
