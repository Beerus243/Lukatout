// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lukatout/pages/connexion.dart';
import 'pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ConnexionScreen(), // <-- Commence par l'écran principal
      routes: {
        '/login': (context) => ConnexionScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}