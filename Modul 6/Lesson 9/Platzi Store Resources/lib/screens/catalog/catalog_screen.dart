import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/l10n/app_l10n.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';

import 'catalog_provider.dart';
import 'widgets/catalog_card.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text(AppStrings.catalog),
      ),
      body: const CatalogView(),
    );
  }
}

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: provider.category.length,
          padding: AppSizes.paddingH16,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 5 / 6,
          ),
          itemBuilder: (_, i) => CatalogCard(catalog: provider.category[i]),
        );
      },
    );
  }
}
