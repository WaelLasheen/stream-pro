import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/download_cubit/download_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/download_cubit/download_state.dart';

class DownloadButton extends StatefulWidget {
  final String videoId;

  const DownloadButton({super.key, required this.videoId});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DownloadCubit>(),
      child: BlocConsumer<DownloadCubit, DownloadState>(
        listener: (context, state) {
          if (state is DownloadSuccess) {
            context.showSuccessSnackBar(message: 'Video saved to gallery!');
            HapticFeedback.mediumImpact(); // Satisfying thud on success
          } else if (state is DownloadError) {
            context.showErrorSnackBar(message: state.message);
            HapticFeedback.heavyImpact(); // Warning buzz on error
          } else if (state is DownloadInProgress) {
            HapticFeedback.lightImpact(); // Subtle tick when starting
          }
        },
        builder: (context, state) {
          final isDownloading = state is DownloadInProgress;
          final isSuccess = state is DownloadSuccess;
          final progress = isDownloading ? state.progress : 0.0;

          final appTheme = context.appTheme;

          // Clean, minimal color palette
          Color bgColor = appTheme.surfaceColor;
          Color contentColor = appTheme.grey700;
          Color iconColor = appTheme.grey700;

          String text = 'Download';
          Widget icon = Icon(
            Icons.download_rounded,
            size: 18.sp,
            color: iconColor,
          );

          if (isDownloading) {
            // Soft primary tint while downloading
            bgColor = appTheme.grey600.withValues(alpha: 0.1);
            contentColor = appTheme.grey600;
            iconColor = appTheme.grey600;
            text = '${(progress * 100).toInt()}%';
            icon = SizedBox(
              width: 16.w,
              height: 16.w,
              child: CircularProgressIndicator(
                value: progress > 0 ? progress : null,
                strokeWidth: 2.5,
                color: iconColor,
              ),
            );
          } else if (isSuccess) {
            // Soft green tint on success
            bgColor = appTheme.successColor.withValues(alpha: 0.1);
            contentColor = appTheme.successColor;
            iconColor = appTheme.successColor;
            text = 'Saved';
            icon = Icon(Icons.check_rounded, size: 18.sp, color: iconColor);
          }

          return GestureDetector(
            onTap: () {
              if (!isDownloading && !isSuccess) {
                context.read<DownloadCubit>().downloadVideo(widget.videoId);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: KeyedSubtree(
                      key: ValueKey(
                        isDownloading
                            ? 'loading'
                            : isSuccess
                            ? 'success'
                            : 'idle',
                      ),
                      child: icon,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      text,
                      key: ValueKey(text),
                      style: TextStyle(
                        color: contentColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
