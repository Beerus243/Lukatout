import 'package:flutter/material.dart';

class MesAnnoncesScreen extends StatelessWidget {
  const MesAnnoncesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes annonces")),
      body: const Center(child: Text("Vos annonces ici")),
    );
  }
}