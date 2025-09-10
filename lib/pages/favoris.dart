import 'package:flutter/material.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favoris")),
      body: const Center(child: Text("Vos favoris ici")),
    );
  }
}