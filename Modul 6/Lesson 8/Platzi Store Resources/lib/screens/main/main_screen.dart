import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_shopper/core/router/app_router.dart';

import '../../core/l10n/app_l10n.dart';
import '../../core/theme/app_icons.dart';

class Main extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const Main({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(activeIcon: AppIcons.homeSelected, icon: AppIcons.homeUnselected, label: AppStrings.home),
          BottomNavigationBarItem(activeIcon: AppIcons.catalogSelected, icon: AppIcons.catalogUnselected, label: AppStrings.catalog),
          BottomNavigationBarItem(activeIcon: AppIcons.cartSelected, icon: AppIcons.cartUnselected, label: AppStrings.cart),
          BottomNavigationBarItem(activeIcon: AppIcons.favoriteSelected, icon: AppIcons.favoriteUnselected, label: AppStrings.favorite),
          BottomNavigationBarItem(activeIcon: AppIcons.profileSelected, icon: AppIcons.profileUnselected, label: AppStrings.profile),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          if (currentIndex != index) {
            String page = switch (index) {
              0 => Routes.home,
              1 => Routes.catalog,
              2 => Routes.cart,
              3 => Routes.favorite,
              4 => Routes.profile,
              _ => Routes.home,
            };
            context.go(page);
          }
        },
      ),
    );
  }
}
