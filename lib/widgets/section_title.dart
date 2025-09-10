import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;
  const SectionTitle({super.key, required this.title, required this.actionLabel, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onActionTap,
          child: Text(actionLabel, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }
}
