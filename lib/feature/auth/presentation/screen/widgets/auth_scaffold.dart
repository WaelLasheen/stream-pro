import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

/// Shared scaffold for the auth screens.
///
/// Paints a subtle two-tone decorative background (soft primary tint in
/// the top corner, secondary tint in the bottom corner) and lays the
/// [child] inside a scrollable, keyboard-friendly padded column.
class AuthScaffold extends StatelessWidget {
  final Widget child;

  const AuthScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Decorative background blobs
          Positioned(
            top: -120.h,
            right: -100.w,
            child: _BackgroundBlob(color: appTheme.primaryColor, size: 260.w),
          ),
          Positioned(
            bottom: -140.h,
            left: -110.w,
            child: _BackgroundBlob(color: appTheme.secondaryColor, size: 280.w),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 420.w),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BackgroundBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withAlpha(40), color.withAlpha(0)],
        ),
      ),
    );
  }
}
