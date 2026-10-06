import 'package:flutter/material.dart';

class LoadMoreListener extends StatelessWidget {
  final VoidCallback? onLoadMore;
  final Widget child;

  const LoadMoreListener({super.key, this.onLoadMore, required this.child});

  @override
  Widget build(BuildContext context) {
    final onLoadMore = this.onLoadMore;

    if (onLoadMore == null) return child;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;

          if (metrics.maxScrollExtent > 0 &&
              metrics.pixels >= metrics.maxScrollExtent * 0.8) {
            onLoadMore();
          }
        }
        return false;
      },
      child: child,
    );
  }
}
