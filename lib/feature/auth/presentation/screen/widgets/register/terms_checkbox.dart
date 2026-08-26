import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

/// Terms & conditions checkbox.
///
/// The checked state is stored in the passed [ValueNotifier] (owned by the
/// parent) and the row rebuilds only itself through [ValueListenableBuilder],
/// so toggling it never rebuilds the whole register screen.
class TermsCheckbox extends StatelessWidget {
  final ValueNotifier<bool> isChecked;

  const TermsCheckbox({super.key, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: isChecked,
      builder: (context, checked, _) {
        return InkWell(
          onTap: () => isChecked.value = !isChecked.value,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: Checkbox(
                    value: checked,
                    onChanged: (value) => isChecked.value = value ?? false,
                    activeColor: appTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    S.current.termsAndConditions,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: appTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
