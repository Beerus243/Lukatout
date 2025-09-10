import 'package:flutter/material.dart';

class NotrePlateformeScreen extends StatelessWidget {
  const NotrePlateformeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notre plateforme")),
      body: const Center(child: Text("À propos de notre plateforme")),
    );
  }
}