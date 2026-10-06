import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class AppCircleNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final String fallbackText;
  final VoidCallback? onTap;

  const AppCircleNetworkImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.fallbackText = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    Widget avatar;

    if (imageUrl.isEmpty) {
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: appTheme.surfaceColor,
        child: Text(
          fallbackText.isNotEmpty ? fallbackText[0].toUpperCase() : '?',
          style: TextStyle(fontSize: radius * 0.8, fontWeight: FontWeight.w600),
        ),
      );
    } else {
      avatar = CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(radius: radius, backgroundImage: imageProvider),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: appTheme.grey500,
          highlightColor: appTheme.grey200,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: appTheme.surfaceColor,
          ),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: radius,
          backgroundColor: appTheme.surfaceColor,
          child: const Icon(Icons.person_outline),
        ),
      );
    }

    if (onTap == null) return avatar;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius * 2),
      child: avatar,
    );
  }
}
