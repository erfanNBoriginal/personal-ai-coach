import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class IconButton extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;
  final void Function() onTapped;

  const IconButton({
    super.key,
    required this.icon,
    required this.onTapped,
    required this.size,
    this.color = const Color(0xFF9DCBEC),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 1, color: U.Theme.secondaryButton),
        borderRadius: BorderRadius.circular(50),
        color: color ?? Colors.white.withValues(alpha: 0.0),
      ),
      child: U.Image.icon(path: icon, size: size),
    );
  }
}
