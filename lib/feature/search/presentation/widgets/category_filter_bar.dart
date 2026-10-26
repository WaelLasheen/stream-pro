import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/entity/category_entity.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class CategoryFilterBar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final ValueNotifier<String?> selectedCategoryNotifier;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategoryNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final theme = Theme.of(context);

    return ValueListenableBuilder<String?>(
      valueListenable: selectedCategoryNotifier,
      builder: (context, selectedCategory, _) {
        return SizedBox(
          height: 40.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length + 1,
            separatorBuilder: (_, __) => 8.horizontalSpace,
            itemBuilder: (context, index) {
              final isAllChip = index == 0;
              final category = isAllChip ? null : categories[index - 1];
              final isSelected = isAllChip
                  ? selectedCategory == null
                  : selectedCategory == category?.name;
              final label = isAllChip ? "All" : category?.name ?? '';

              return ChoiceChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (_) {
                  selectedCategoryNotifier.value = isAllChip
                      ? null
                      : category?.name;
                },
                selectedColor: appTheme.primaryColor,
                backgroundColor: appTheme.surfaceColor,
                labelStyle: theme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 13.sp,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                showCheckmark: false,
                shadowColor: appTheme.grey800,
                selectedShadowColor: appTheme.grey800,
              );
            },
          ),
        );
      },
    );
  }
}
