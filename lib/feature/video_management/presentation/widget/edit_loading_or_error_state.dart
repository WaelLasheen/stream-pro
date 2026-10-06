import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stream_pro/core/shared/widgets/app_error_widget/app_error_widget.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_state.dart';

class EditLoadingOrErrorState extends StatelessWidget {
  final EditVideoState state;
  final String videoId;

  const EditLoadingOrErrorState({
    super.key,
    required this.state,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    final currentState = state;

    if (currentState is EditVideoError) {
      return AppErrorWidget(
        message: currentState.message,
        retryIcon: Icons.refresh,
        onRetry: () =>
            context.read<EditVideoCubit>().loadVideo(videoId: videoId),
      );
    }

    return const EditVideoShimmer();
  }
}

class EditVideoShimmer extends StatelessWidget {
  const EditVideoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: appTheme.grey500,
      highlightColor: appTheme.grey200,
      child: ListView(
        children: [
          // Video Player Placeholder
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE2E8F0),
            ),
          ),
          28.verticalSpace,
          // Thumbnail Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                // Thumbnail Image
                Container(
                  width: 120.w,
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 12.w),
                // Change Thumbnail Button
                Expanded(
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Publish Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),

          // Video Title Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.w,
                  height: 14.h,
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE2E8F0),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          ),

          // Description Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 14.h,
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE2E8F0),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          ),

          // Category Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.w,
                  height: 14.h,
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE2E8F0),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          ),

          // Tags Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 14.h,
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE2E8F0),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          ),

          // Save Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
