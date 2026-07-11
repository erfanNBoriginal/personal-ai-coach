import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;



class ChatBubble extends StatelessWidget {
  final String text;

  const ChatBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: U.Theme.secondaryButton,
        boxShadow: [BoxShadow(blurRadius: 10, color: U.Theme.shadow)],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: U.Text(text: text),
      ),
    );
  }
}
