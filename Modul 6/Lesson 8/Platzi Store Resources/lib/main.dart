import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/core/router/app_router.dart';
import 'package:provider_shopper/core/theme/app_theme.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // providers...
      ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: AppRoute.router,
      ),
    );
  }
}
