import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/toggle_subscription_cubit/toggle_subscription_cubit.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/toggle_subscription_cubit/toggle_subscription_state.dart';
import 'package:stream_pro/generated/l10n.dart';

class SubscribeButton extends StatelessWidget {
  final String channelId;
  final bool isSubscribed;

  const SubscribeButton({
    super.key,
    required this.channelId,
    required this.isSubscribed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ToggleSubscriptionCubit>()..init(isSubscribed),
      child: BlocConsumer<ToggleSubscriptionCubit, ToggleSubscriptionState>(
        listener: (context, state) {
          if (state is ToggleSubscriptionErrorState) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        builder: (context, state) {
          final currentIsSubscribed = state.isSubscribed;
          final theme = Theme.of(context);
          final appTheme = context.appTheme;

          // Target values for smooth animation
          final targetColor = currentIsSubscribed
              ? appTheme.surfaceColor
              : appTheme.primaryColor;

          final targetTextColor = currentIsSubscribed
              ? (theme.textTheme.bodyLarge?.color ?? appTheme.textPrimary)
              : theme.colorScheme.onPrimary;

          final targetBorderColor = currentIsSubscribed
              ? appTheme.grey500
              : appTheme.primaryColor;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: targetColor,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: targetBorderColor, width: 1.5.w),
              boxShadow: currentIsSubscribed
                  ? []
                  : [
                      BoxShadow(
                        color: appTheme.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 8.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
            ),
            child: InkWell(
              onTap: () {
                context.read<ToggleSubscriptionCubit>().toggleSubscription(
                  channelId,
                  currentIsSubscribed,
                );
              },
              borderRadius: BorderRadius.circular(18.r),
              splashColor: targetTextColor.withValues(alpha: 0.1),
              highlightColor: targetTextColor.withValues(alpha: 0.05),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  // Elastic "pop" animation when text/icon changes
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                // The key forces AnimatedSwitcher to recognize the state change
                child: Padding(
                  key: ValueKey(currentIsSubscribed),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (currentIsSubscribed) ...[
                        Icon(
                          Icons.notifications_active_outlined,
                          color: targetTextColor,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                      ],
                      Text(
                        currentIsSubscribed
                            ? S.current.subscribed
                            : S.current.subscribe,
                        style: TextStyle(
                          color: targetTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Rubik',
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
