import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            SizedBox(width: 8.w),
            const Text('•', style: TextStyle(color: Colors.grey)),
            SizedBox(width: 8.w),
            Text(
              _timeAgo(widget.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
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
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ],
    );
  }

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}