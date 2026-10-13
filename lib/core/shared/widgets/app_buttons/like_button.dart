import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/likes_cubit/likes_cubit.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/likes_cubit/likes_state.dart';

class LikeButton extends StatelessWidget {
  final String videoId;
  final bool initialIsLiked;
  final int initialLikesCount;

  const LikeButton({
    super.key,
    required this.videoId,
    required this.initialIsLiked,
    this.initialLikesCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LikesCubit>()
            ..init(isLiked: initialIsLiked, likesCount: initialLikesCount),
      child: BlocConsumer<LikesCubit, LikesState>(
        listener: (context, state) {
          if (state is LikesFailure) {
            context.showErrorSnackBar(message: state.errorMessage);
          }
        },
        builder: (context, state) {
          final isLiked = state.isLiked;
          final likesCount = state.likesCount;
          final theme = Theme.of(context);
          final appTheme = context.appTheme;

          return InkWell(
            onTap: () {
              context.read<LikesCubit>().toggleLike(videoId);
            },
            borderRadius: BorderRadius.circular(20.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isLiked
                    ? appTheme.primaryColor.withValues(alpha: 0.1)
                    : appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(isLiked),
                      color: isLiked ? appTheme.primaryColor : appTheme.grey700,
                      size: 22.r,
                    ),
                  ),
                  4.horizontalSpace,
                  Text(
                    likesCount.formatCount(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isLiked ? appTheme.primaryColor : appTheme.grey700,
                      fontWeight: FontWeight.w600,
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
