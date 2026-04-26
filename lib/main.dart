import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/providers.dart';
import 'core/re0_theme.dart';
import 'features/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const Re0App(),
    ),
  );
}

class Re0App extends StatelessWidget {
  const Re0App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '从零生图',
      debugShowCheckedModeBanner: false,
      theme: Re0Theme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
