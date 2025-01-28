import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

class AppFillButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AppFillButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: AppSizes.paddingH24,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
        backgroundColor: AppColors.black,
        overlayColor: AppColors.white,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
