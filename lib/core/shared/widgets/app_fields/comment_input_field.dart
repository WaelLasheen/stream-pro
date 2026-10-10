import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_state.dart.dart';
import '../../../../feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';

class CommentInputField extends StatefulWidget {
  final String videoId;
  // final UserParams userParams;

  const CommentInputField({
    super.key,
    required this.videoId,
    // required this.userParams,
  });

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitComment() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    context.read<CommentsCubit>().addComment(widget.videoId, content);
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: (context, state) {
        if (state is CommentsError) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        final isSubmitting = state is CommentsLoaded && state.isSubmitting;

        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          decoration: BoxDecoration(
            color: appTheme.surfaceColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10.r,
                offset: Offset(0, -4.h),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: AppFormField(
              controller: _controller,
              focusNode: _focusNode,
              hint: 'Add a comment...',
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (_) => _submitComment(),
              enabled: !isSubmitting,
              fillColor: appTheme.grey200.withValues(alpha: 0.5),
              idleBorderColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
