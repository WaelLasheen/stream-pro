import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_network_image.dart';
import 'package:stream_pro/feature/search/domain/entities/search_suggestion_entity.dart';

class SearchSuggestionTile extends StatelessWidget {
  final SearchSuggestionEntity suggestion;
  final VoidCallback onTap;

  const SearchSuggestionTile({
    super.key,
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            AppNetworkImage(
              imageUrl: suggestion.thumbnailUrl,
              width: 96.w,
              height: 54.h,
              borderRadius: BorderRadius.circular(10.r),
              errorIcon: Icons.movie_outlined,
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                suggestion.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
            8.horizontalSpace,
            Icon(
              Icons.chevron_right_rounded,
              size: 22.r,
              color: theme.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
