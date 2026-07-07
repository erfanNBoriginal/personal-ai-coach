import 'dart:ui';

class Theme {
  static final Color background = Color(0xFFF7F7F7);
  static final Color primary = Color(0xFF4E38B2);
  static final Color white = Color(0xFFFFFFFF);
  // static   final  primary = Color(value)
  static final Color onBackground = Color(0xFFD8CEFF);

  static final afternoonPallet = LinearBackground(
    background1: Color(0xFFFCFCFC),
    background2: Color(0xFFE3F0FF),
    background3: Color(0xFFE8C2FF),
  );

  // Text colors
  static final primaryText = Color(0xFF352A7C);
  static final secondaryText = Color(0xFFFFFFFF);
  static final tertiaryText = Color(0xFF143966);
  static final quaternaryText = Color(0xFF768393);
  //
  static final outline = Color(0xFFCBCDFB);
  static final outlineHigh = Color(0xFF321C98);

  // Surface
  static final surface = Color(0xFFCBFBF9);
  static final surfaceLight = Color(0xFFBAA9F6);
  static final surfaceHigh = Color(0xFF4E38B2);

  // Divider
  static final divider = Color(0xFF9DCBEC);

  // Buttons
  static final secondaryButton = Color(0xFF917AE5);
  // static final secondaryButton = Color(0xFF352A7C);
  static final tertiaryButton = Color(0xFFB8B2D6);

  // Border
  static final primaryBorder = Color(0xFF9D89E8);

  // Radius
  static double radius = 50.0;
}

class LinearBackground {
  final Color background1;
  final Color background2;
  final Color background3;

  LinearBackground({
    required this.background1,
    required this.background2,
    required this.background3,
  });
}
