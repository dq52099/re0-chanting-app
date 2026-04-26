import 'package:flutter/material.dart';
import '../chanting/chanting_screen.dart';
import '../loop/loop_screen.dart';
import '../corridor/corridor_screen.dart';
import '../sanctuary/sanctuary_screen.dart';
import '../../core/re0_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const ChantingScreen(),
    const LoopScreen(),
    const CorridorScreen(),
    const SanctuaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Re0Theme.crystalBlue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.auto_fix_high), label: '咏唱'),
          BottomNavigationBarItem(icon: Icon(Icons.loop), label: '死亡回归'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '记忆回廊'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: '圣域'),
        ],
      ),
    );
  }
}
