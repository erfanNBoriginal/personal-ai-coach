import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

enum OutlineIconButtonSize { primary, secondary }

enum OutlineIconButtonColor { primary, secondary }

class OutlineIconButton extends StatelessWidget {
  final String path;
  final double opacity;
  final Function() onTap;
  final OutlineIconButtonSize? size;
  final OutlineIconButtonColor? color;
  const OutlineIconButton({
    super.key,
    required this.path,
    required this.onTap,
    this.opacity = 0.0,
    this.size = OutlineIconButtonSize.primary,
    this.color = OutlineIconButtonColor.primary,
  });

  ({double icon, EdgeInsetsGeometry padding}) get getSize {
    switch (size!) {
      case OutlineIconButtonSize.primary:
        return (
          icon: 18,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 18, vertical: 9),
        );
      case OutlineIconButtonSize.secondary:
        return (icon: 14, padding: EdgeInsetsGeometry.all(12));
    }
  }

  Color get getColor {
    switch (color!) {
      case OutlineIconButtonColor.primary:
        return U.Theme.secondaryButton;
      case OutlineIconButtonColor.secondary:
        return U.Theme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: U.Theme.white.withValues(alpha: opacity),
          border: Border.all(width: 1, color: getColor),
        ),
        child: Padding(
          padding: getSize.padding,
          child: U.Image.icon(path: path, size: getSize.icon),
        ),
      ),
    );
  }
}
