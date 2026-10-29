import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/comments/domain/entities/comment_entity.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/mappers/user_mapper.dart';
import 'package:stream_pro/feature/comments/presentation/widgets/comment_bottom_sheet/comment_form_content.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/generated/l10n.dart';

class CommentBottomSheet extends StatefulWidget {
  final String videoId;
  final String? parentId;
  final String? parentUserName;
  final CommentEntity? editingComment;
  final String? editingReplyParentId;

  const CommentBottomSheet({
    super.key,
    required this.videoId,
    this.parentId,
    this.parentUserName,
    this.editingComment,
    this.editingReplyParentId,
  });

  bool get isEditing => editingComment != null;
  bool get isReplyEdit => editingReplyParentId != null;
  bool get isReplyAdd => !isEditing && parentId != null;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _hasTextNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.editingComment?.content ?? '',
    );
    _hasTextNotifier.value = _controller.text.trim().isNotEmpty;

    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (_hasTextNotifier.value != hasText) {
        _hasTextNotifier.value = hasText;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _hasTextNotifier.dispose();
    super.dispose();
  }

  void _submit() {
    final content = _controller.text.trim();
    if (content.isEmpty || !mounted) return;

    final profile = context.read<ProfileCubit>().state.profile;
    if (profile == null) {
      context.showErrorSnackBar(message: S.current.profileIsStillLoading);
      return;
    }
    final user = profile.toUserParams();

    // 1. Trigger the optimistic action in the Cubit (No await!)
    if (widget.isEditing) {
      if (widget.isReplyEdit) {
        context.read<RepliesCubit>().updateReply(
          parentId: widget.editingReplyParentId!,
          commentId: widget.editingComment!.commentId,
          content: content,
        );
      } else {
        context.read<CommentsCubit>().updateComment(
          widget.editingComment!.commentId,
          content,
        );
      }
    } else if (widget.isReplyAdd) {
      final parentId = widget.parentId!;
      context.read<RepliesCubit>().addReply(
        videoId: widget.videoId,
        parentId: parentId,
        content: content,
        user: user,
        onSuccess: () =>
            context.read<CommentsCubit>().incrementReplyCount(parentId),
        onFailure: () =>
            context.read<CommentsCubit>().decrementReplyCount(parentId),
      );
    } else {
      context.read<CommentsCubit>().addComment(widget.videoId, content, user);
    }

    if (mounted) {
      _controller.clear();
      _focusNode.unfocus();
      context.navigateBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEditing
        ? S.current.editComment
        : widget.isReplyAdd
        ? S.current.reply
        : S.current.addAPublicComment;

    final hint = widget.isEditing
        ? S.current.editYourComment
        : widget.isReplyAdd
        ? S.current.writeAReply
        : S.current.whatAreYourThoughts;

    return CommentFormContent(
      title: title,
      hint: hint,
      isReplyAdd: widget.isReplyAdd,
      parentUserName: widget.parentUserName,
      controller: _controller,
      focusNode: _focusNode,
      hasTextNotifier: _hasTextNotifier,
      isEditing: widget.isEditing,
      onSubmit: _submit,
    );
  }
}
