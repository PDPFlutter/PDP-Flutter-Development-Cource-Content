import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_image_card.dart';
import '../../../models/category/category.dart';

class CatalogCard extends StatefulWidget {
  final Category catalog;
  const CatalogCard({required this.catalog, super.key});

  @override
  State<CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends State<CatalogCard> with AutomaticKeepAliveClientMixin<CatalogCard> {
  void _goDetail() {
    context.go(Routes.categoryDetailWithId(widget.catalog.id));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: _goDetail,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImageCard(imageUrl: widget.catalog.image),

          Padding(
            padding: AppSizes.paddingL8R8T8,
            child: Text(
              widget.catalog.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
