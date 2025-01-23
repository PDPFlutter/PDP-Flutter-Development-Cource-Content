// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTextStyles {
  static TextStyle get title => GoogleFonts.lora(
    fontSize: AppSizes.fs20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  
  static TextStyle get subtitle => GoogleFonts.lora(
    fontSize: AppSizes.fs20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  
  static TextStyle get body => GoogleFonts.lora(
    fontSize: AppSizes.fs18,
    color: AppColors.black,
  );
  
  static TextStyle get buttonText => GoogleFonts.nunito(
    fontWeight: FontWeight.w500,
    fontSize: AppSizes.fs20,
    color: AppColors.white,
  );
}
