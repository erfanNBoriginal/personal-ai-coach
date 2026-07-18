import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        U.AppBar(title: 'todays tasks', blur: true),
        SizedBox(height: 22),
        // U.ScrollableTabview(pages: pages)
      ],
    );
  }
}
