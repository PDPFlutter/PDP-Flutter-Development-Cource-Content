import 'package:flutter/material.dart';

import '../../core/l10n/app_l10n.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/widgets/product_view.dart';
import '../../core/widgets/search_button.dart';
import '../../models/product/product.dart';
import '../../service/network_service.dart';

class CatalogDetailScreen extends StatelessWidget {
  final String catalogID;
  const CatalogDetailScreen({required this.catalogID, super.key});

  Future<List<Product>> _products(String categoryID) async {
    final data = await Network.request(api: Apis.productsByCategory(categoryID));
    if (data != null) {
      return Network.parseProductList(data);
    } else {
      throw Exception('Failed to load Product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text(AppStrings.product),
        actions: const [
          IconButton(
            onPressed: () {},
            icon: AppIcons.search,
          ),
          AppSizes.w12,
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _products(catalogID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const SizedBox.shrink();
            return ProductView(products: snapshot.data!);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
