import 'package:flutter/material.dart';

class CentreAideScreen extends StatelessWidget {
  const CentreAideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Centre d’aide")),
      body: const Center(child: Text("Centre d’aide et FAQ")),
    );
  }
}