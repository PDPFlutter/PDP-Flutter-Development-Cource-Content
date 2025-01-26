import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/l10n/app_l10n.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/string_utils.dart';
import '../../core/widgets/product_card.dart';
import '../../models/product/product.dart';
import '../../service/network_service.dart';

class ProductScreen extends StatefulWidget {
  final String id;

  const ProductScreen({required this.id, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<Product> _fetchProduct() async {
    final data = await Network.request(api: Apis.products, id: widget.id);
    if (data != null) {
      return Network.parseProduct(data);
    } else {
      throw Exception('Failed to load Product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.transparent, surfaceTintColor: AppColors.transparent),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder<Product>(
        future: _fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductImagesSlider(images: product.images),

                  /// #title
                  Padding(
                    padding: AppSizes.paddingT16L16R8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: AppIcons.heart.copyWith(height: 36, width: 36),
                        ),
                      ],
                    ),
                  ),

                  /// #price
                  Padding(
                    padding: AppSizes.paddingAll16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _ProductRate(),
                        Text(
                          "${product.price}\$",
                          style: AppTextStyles.title,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: AppColors.grey200,
                  ),

                  /// #quantity and add to cart
                  const Padding(
                    padding: AppSizes.paddingT24L16R16B24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// #quantity
                        _ProductQuantity(),

                        /// #add to cart
                        _AddToCart(),
                      ],
                    ),
                  ),

                  _Description(description: product.description),

                  _SimilarProduct(product: product),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // write normal text
            return Center(child: Text('${snapshot.error}'));
          }

          // add shimmer
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// #description
        Padding(
          padding: AppSizes.paddingL16T8,
          child: Text(
            AppStrings.description,
            style: AppTextStyles.title,
          ),
        ),

        Padding(
          padding: AppSizes.paddingL16T8R16B24,
          child: Text(description, style: AppTextStyles.body),
        ),
      ],
    );
  }
}

class _AddToCart extends StatelessWidget {
  const _AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: AppSizes.paddingH24,
        fixedSize: const Size(double.nan, 50),
        backgroundColor: AppColors.black,
        overlayColor: AppColors.white,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcons.cartSelected.copyWith(color: AppColors.white),
          AppSizes.w8,
          Text(
            AppStrings.addToCart,
            style: AppTextStyles.buttonText,
          ),
        ],
      ),
    );
  }
}

class _ProductQuantity extends StatelessWidget {
  const _ProductQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSizes.w4,
          IconButton(
            onPressed: () {},
            icon: AppIcons.minus.copyWith(height: 32, width: 32),
          ),
          AppSizes.w8,
          const Text(
            "1",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSizes.w8,
          IconButton(
            onPressed: () {},
            icon: AppIcons.plus.copyWith(height: 28, width: 28),
          ),
          AppSizes.w4,
        ],
      ),
    );
  }
}

class _ProductRate extends StatelessWidget {
  const _ProductRate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: AppIcons.startFill.copyWith(width: 26.004, height: 24),
          ),
        AppSizes.w10,
        const Text(
          "5,0",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProductImagesSlider extends StatelessWidget {
  const _ProductImagesSlider({required this.images, super.key});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: StringUtils.extractUrlFromString(images[index]),
            placeholder: (_, __) => Container(color: AppColors.grey200),
            errorWidget: (_, __, ___) => Container(color: AppColors.grey200),
          );
        },
      ),
    );
  }
}

class _SimilarProduct extends StatelessWidget {
  final Product product;

  const _SimilarProduct({required this.product, super.key});

  Future<List<Product>> _similarProducts(int categoryID, int productID) async {
    final data = await Network.request(api: Apis.productsByCategory(categoryID));
    if (data != null) {
      return Network.parseProductList(data)..removeWhere((item) => item.id == productID);
    } else {
      throw Exception('Failed to load Product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33 * MediaQuery.sizeOf(context).width / 43 + 72,
      child: FutureBuilder<List<Product>>(
        future: _similarProducts(product.category.id, product.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) return const SizedBox.shrink();
            final items = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// #similar products
                Padding(
                  padding: AppSizes.paddingL16T8,
                  child: Text(
                    AppStrings.similarProducts,
                    style: AppTextStyles.title,
                  ),
                ),

                Flexible(
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: AppSizes.paddingH16V16,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2.15,
                        child: Padding(
                          padding: AppSizes.paddingH4,
                          child: ProductCard(product: items[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
