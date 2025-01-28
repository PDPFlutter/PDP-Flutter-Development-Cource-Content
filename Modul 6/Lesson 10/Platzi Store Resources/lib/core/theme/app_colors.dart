import 'package:flutter/material.dart';

sealed class AppColors {
  // Primary Colors
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  
  // Custom Colors
  static const borderColor = Color(0xFFE3E5E5);
  
  // Gray Shades
  static final grey200 = Colors.grey.shade200;
  static final grey800 = Colors.grey.shade800;
  static const grey = Color(0xFFF2F4F5);
  static const greyDark = Color(0xFF979C9E);
  static const greyText = Color(0xFFCDCFD0);

  // Random Colors for placeholders
  static List<Color> get randomColors => Colors.primaries;
}
