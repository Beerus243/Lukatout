import 'package:flutter/material.dart';

class MentionsLegalesScreen extends StatelessWidget {
  const MentionsLegalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mentions légales")),
      body: const Center(child: Text("Mentions légales de la plateforme")),
    );
  }
}