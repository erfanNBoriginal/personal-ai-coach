import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class AppBar extends StatelessWidget {
  final String title;

  const AppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27.0),
      child: Container(
        height: 77,
        color: U.Theme.background.withValues(alpha: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: U.Image(path: U.Icons.back, width: 28, height: 14),
            ),
            U.Text(text: title),
            InkWell(
              onTap: () {},
              child: U.Image.icon(path: U.Icons.wrong, size: 14),
            ),
          ],
        ),
      ),
    );
  }
}
