import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/product/product.dart';
import '../router/app_router.dart';
import '../theme/app_icons.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'app_image_card.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({required this.product, super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with AutomaticKeepAliveClientMixin<ProductCard> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImageCard(imageUrl: widget.product.images.first),
        Padding(
          padding: AppSizes.paddingL8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.product.price}\$",
                style: AppTextStyles.subtitle,
              ),
              // todo: not finished yet
              IconButton(onPressed: () {}, icon: AppIcons.heart),
            ],
          ),
        ),
        Padding(
          padding: AppSizes.paddingL8R8,
          child: Text(
            widget.product.title,
            style: AppTextStyles.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
