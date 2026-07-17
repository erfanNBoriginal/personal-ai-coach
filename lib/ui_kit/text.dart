import 'package:flutter/material.dart' as M;
import 'package:flutter/widgets.dart';

enum TextWeight { sm, md, bold, semiBold }

enum TextSize { s12, s14, s16, s18 }

class Text extends M.StatelessWidget {
  final String text;
  final M.Color? color;
  final TextWeight? textWeight;
  final TextSize? textSize;
  final bool isCentered;
  final TextOverflow overFlow;
  final bool softWrap;
  const Text({
    super.key,
    required this.text,
    this.color,
    this.textSize = TextSize.s12,
    this.textWeight = TextWeight.md,
    this.isCentered = false,
    this.softWrap = false,
    this.overFlow = TextOverflow.ellipsis,
  });
  // ignore: unused_element
  M.FontWeight get _getWeight {
    switch (textWeight) {
      case TextWeight.sm:
        return M.FontWeight.w400;
      case TextWeight.md:
        return M.FontWeight.w500;
      case TextWeight.bold:
        return M.FontWeight.w700;
      case TextWeight.semiBold:
        return M.FontWeight.w600;
      case null:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  double? get _getSize {
    switch (textSize) {
      case TextSize.s12:
        return 12;
      case TextSize.s14:
        return 14;
      case TextSize.s16:
        return 16;
      case TextSize.s18:
        return 18;

      // throw UnimplementedError().message;
      case null:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  @override
  M.Widget build(M.BuildContext context) {
    return M.Text(
      text,
      softWrap: softWrap,
      overflow: overFlow,
      textAlign:isCentered ? M.TextAlign.center : null,
      style: M.TextStyle(
        fontWeight: _getWeight,
        fontSize: _getSize,
        color: color,
      ),
    );
  }
}
