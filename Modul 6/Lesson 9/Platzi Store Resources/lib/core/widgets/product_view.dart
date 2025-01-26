import 'package:flutter/material.dart';

import '../../models/product/product.dart';
import 'product_card.dart';

class ProductView extends StatelessWidget {
  final List<Product> products;
  final ScrollController? controller;
  const ProductView({required this.products, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      controller: controller,
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 4 / 6.6,
      ),
      itemBuilder: (_, i) => ProductCard(product: products[i]),
    );
  }
}
