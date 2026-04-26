import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/re0_theme.dart';
import 'features/chanting/chanting_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Re0App(),
    ),
  );
}

class Re0App extends StatelessWidget {
  const Re0App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RE0 - 从零开始的生图生活',
      debugShowCheckedModeBanner: false,
      theme: Re0Theme.lightTheme,
      home: const ChantingScreen(),
    );
  }
}
