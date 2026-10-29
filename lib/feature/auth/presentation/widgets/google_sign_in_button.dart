import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppButton(
      text: S.current.continueWithGoogle,
      isPrimary: false,
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      border: BorderSide(color: appTheme.boarderPrimary),
      textColor: appTheme.textPrimary,
      height: 52.h,
      borderRadius: 16.r,
      icon: SvgPicture.asset(ImagePath.google),
    );
  }
}
