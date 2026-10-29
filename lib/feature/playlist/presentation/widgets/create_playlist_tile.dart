import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class CreatePlaylistTile extends StatelessWidget {
  final VoidCallback onTap;

  const CreatePlaylistTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 22.r,
              color: appTheme.primaryColor,
            ),
            12.horizontalSpace,
            Text(
              S.current.createNewPlaylist,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: appTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
