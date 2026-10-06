import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/formatters.dart';

class VideoHeaderWidget extends StatefulWidget {
  final String title;
  final int views;
  final DateTime createdAt;
  final String description;

  const VideoHeaderWidget({
    super.key,
    required this.title,
    required this.views,
    required this.createdAt,
    required this.description,
  });

  @override
  State<VideoHeaderWidget> createState() => _VideoHeaderWidgetState();
}

class _VideoHeaderWidgetState extends State<VideoHeaderWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Text(
              '${widget.views} views',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
            SizedBox(width: 8.w),
            Text('•', style: TextStyle(color: theme.hintColor)),
            SizedBox(width: 8.w),
            Text(
              widget.createdAt.timeAgo(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
        if (widget.description.isNotEmpty) ...[
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Text(
              widget.description,
              maxLines: isExpanded ? null : 2,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ],
    );
  }
}
