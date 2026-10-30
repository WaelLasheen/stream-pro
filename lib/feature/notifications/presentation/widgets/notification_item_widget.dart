import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../domain/entities/notification_item_entity.dart';
import '../extension/notification_type_visuals.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItemEntity item;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const NotificationItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final theme = Theme.of(context);
    final typeColor = item.type.color(context);

    return Dismissible(
      key: Key(item.notificationId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: appTheme.redNormalColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: context.appTheme.surfaceColor,
          size: 24.r,
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: item.isRead
                ? theme.cardColor
                : appTheme.primaryTint.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: item.isRead
                  ? appTheme.boarderPrimary
                  : appTheme.primaryColor.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.grey800.withAlpha(12),
                blurRadius: 12.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.type.icon, color: typeColor, size: 22.r),
              ),
              12.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: item.isRead
                            ? FontWeight.w500
                            : FontWeight.w700,
                        color: appTheme.textPrimary,
                        height: 1.3,
                      ),
                    ),
                    6.verticalSpace,
                    Text(
                      timeago.format(item.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appTheme.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),

              8.horizontalSpace,

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!item.isRead)
                    Container(
                      width: 8.w,
                      height: 8.w,
                      margin: EdgeInsets.only(bottom: 6.h),
                      decoration: BoxDecoration(
                        color: appTheme.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: appTheme.grey500,
                    size: 20.r,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
