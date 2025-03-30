import 'dart:ffi';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/view/game_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GameApp(),
    );
  }
}
