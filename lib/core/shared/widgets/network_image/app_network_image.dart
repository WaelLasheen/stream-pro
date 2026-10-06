import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget? errorWidget;
  final IconData? errorIcon;
  final Color? color;
  final BlendMode? colorBlendMode;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.errorIcon,
    this.color,
    this.colorBlendMode,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    if (imageUrl.isEmpty) {
      return _wrap(
        errorWidget ??
            ErrorIconWidget(icon: errorIcon, width: width, height: height),
      );
    }

    return _wrap(
      CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: appTheme.grey500,
          highlightColor: appTheme.grey200,
          child: Container(
            width: width,
            height: height,
            color: appTheme.surfaceColor,
          ),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            ErrorIconWidget(
              width: width,
              height: height,
              icon: errorIcon ?? Icons.broken_image_outlined,
            ),
      ),
    );
  }

  Widget _wrap(Widget child) {
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }
}

class ErrorIconWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? color;
  final double? size;

  const ErrorIconWidget({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      color: color ?? theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          icon ?? Icons.image_not_supported_outlined,
          size: size ?? 30.r,
        ),
      ),
    );
  }
}
