// lib/core/theme/app_sizes.dart
import 'package:flutter/material.dart';

class AppSizes {
  // Padding
  static const paddingAll16 = EdgeInsets.all(16);
  static const paddingH16 = EdgeInsets.symmetric(horizontal: 16);
  static const paddingH24 = EdgeInsets.symmetric(horizontal: 24);
  static const paddingH4 = EdgeInsets.symmetric(horizontal: 4);
  static const paddingH16V16 = EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  
  static const paddingL16 = EdgeInsets.only(left: 16);
  static const paddingL8 = EdgeInsets.only(left: 8);
  static const paddingL8R8 = EdgeInsets.only(left: 8, right: 8);
  static const paddingL8R8T8 = EdgeInsets.only(left: 8, right: 8, top: 8);
  static const paddingL16T8 = EdgeInsets.only(left: 16, top: 8);
  static const paddingL16T8R16B24 = EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 24);
  static const paddingT16L16R8 = EdgeInsets.only(top: 16, left: 16, right: 8);
  static const paddingT24L16R16B24 = EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24);
  static const paddingR4 = EdgeInsets.only(right: 4);
  
  // SizedBox - Width
  static const w4 = SizedBox(width: 4);
  static const w8 = SizedBox(width: 8);
  static const w10 = SizedBox(width: 10);
  static const w12 = SizedBox(width: 12);
  
  // Font Sizes
  static const fs18 = 18.0;
  static const fs20 = 20.0;
  
  // Other Sizes
  static const zero = 0.0;
}
