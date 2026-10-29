import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/generated/l10n.dart';

class SliverSectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const SliverSectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(12, 16, 12, 8),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: padding,
        child: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class SliverLoadMoreLoader extends StatelessWidget {
  const SliverLoadMoreLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }
}

class SliverLoadMoreError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const SliverLoadMoreError({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            if (onRetry != null) ...[
              8.verticalSpace,
              TextButton(onPressed: onRetry, child: Text(S.current.retry)),
            ],
          ],
        ),
      ),
    );
  }
}

class SliverEndOfList extends StatelessWidget {
  final String? message;

  const SliverEndOfList({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Center(
          child: Text(
            message ?? S.current.noMoreItems,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}
