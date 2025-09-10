import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LukatoutApp());
}

class LukatoutApp extends StatelessWidget {
  const LukatoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lukatout',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF6900), // Le Bon Coin orange
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}