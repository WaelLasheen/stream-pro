import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_bottom_sheet/drag_handle_widget.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_bottom_sheet/replying_badge_widget.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_bottom_sheet/send_button_widget.dart';

class CommentFormContent extends StatelessWidget {
  final String title;
  final String hint;
  final bool isReplyAdd;
  final String? parentUserName;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<bool> hasTextNotifier;
  final bool isEditing;
  final VoidCallback onSubmit;

  const CommentFormContent({
    super.key,
    required this.title,
    required this.hint,
    required this.isReplyAdd,
    this.parentUserName,
    required this.controller,
    required this.focusNode,
    required this.hasTextNotifier,
    required this.isEditing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: hasTextNotifier,
      builder: (context, hasText, _) {
        final canSend = hasText;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              border: Border(
                top: BorderSide(color: appTheme.boarderPrimary, width: 1.w),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DragHandleWidget(),
                SizedBox(height: 16.h),
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appTheme.textPrimary,
                  ),
                ),
                if (isReplyAdd && parentUserName != null) ...[
                  SizedBox(height: 8.h),
                  ReplyingBadgeWidget(userName: parentUserName!),
                ],
                SizedBox(height: 14.h),
                AppFormField(
                  controller: controller,
                  focusNode: focusNode,
                  hint: hint,
                  maxLines: 4,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textAlignVertical: TextAlignVertical.top,
                  onFieldSubmitted: (_) => onSubmit(),
                  suffixWidget: SendButtonWidget(
                    canSend: canSend,
                    isEditing: isEditing,
                    onSubmit: onSubmit,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
