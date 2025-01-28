import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_fill_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the datas completely!")),
      );
      return;
    }

    final success = await context.read<AuthProvider>().login(
          _emailController.text,
          _passwordController.text,
        );
    if (success && mounted) {
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSizes.paddingAll16,
          child: Consumer<AuthProvider>(builder: (context, provider, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSizes.h200,
                AppIcons.logo.copyWith(height: 75, width: 75),
                AppSizes.h24,
                Text(AppStrings.login, style: AppTextStyles.headlineMedium),
                AppSizes.h16,
                AppTextField(
                    controller: _emailController,
                    iconData: CupertinoIcons.envelope,
                    hintText: AppStrings.email,
                    enabled: !provider.loading),
                AppSizes.h16,
                AppTextField(
                  controller: _passwordController,
                  iconData: CupertinoIcons.padlock_solid,
                  hintText: AppStrings.password,
                  obscureText: true,
                  enabled: !provider.loading,
                ),
                AppSizes.h48,
                AppFillButton(
                  onPressed: provider.loading ? null : _signIn,
                  child: provider.loading
                      ? const CircularProgressIndicator(color: AppColors.white, strokeWidth: 2)
                      : Text(AppStrings.login, style: AppTextStyles.buttonText),
                ),
                AppSizes.h24,
                RichText(
                  text: TextSpan(style: AppTextStyles.inputText.copyWith(fontSize: 20), children: [
                    const TextSpan(
                      text: AppStrings.signUpPrompt,
                      style: TextStyle(color: AppColors.greyText),
                    ),
                    TextSpan(
                      text: AppStrings.signUp,
                      recognizer: TapGestureRecognizer()..onTap = () => context.go(Routes.signUp),
                    ),
                  ]),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
