import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/video_card/video_card_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class LibrarySeeAllTile extends StatelessWidget {
  final VoidCallback onTap;

  const LibrarySeeAllTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTheme = context.appTheme;

    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: 96.w,
          height: VideoCardWidget.compactThumbnailHeight,
          decoration: BoxDecoration(
            color: appTheme.primaryTint,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: appTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18.r,
                  color: appTheme.onPrimary,
                ),
              ),
              6.verticalSpace,
              Text(
                'See all',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: appTheme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
