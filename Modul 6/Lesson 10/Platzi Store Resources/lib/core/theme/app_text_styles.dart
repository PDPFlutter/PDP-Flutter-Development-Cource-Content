import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

sealed class AppTextStyles {
  static TextStyle get headlineMedium => GoogleFonts.lora(
    fontSize: AppSizes.fs32,
    color: AppColors.black,
  );
  
  static TextStyle get title => GoogleFonts.lora(
    fontSize: AppSizes.fs24,
    fontWeight: FontWeight.w500,
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
  
  static TextStyle get inputText => GoogleFonts.nunito(
    fontSize: AppSizes.fs16,
    color: AppColors.black,
  );
}
