import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/string_utils.dart';

class AppImageCard extends StatelessWidget {
  final String imageUrl;

  const AppImageCard({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: CachedNetworkImage(
          imageUrl: StringUtils.extractUrlFromString(imageUrl),
          placeholder: (_, __) => placeholder,
          errorWidget: (_, __, ___) => placeholder,
        ),
      ),
    );
  }
}
