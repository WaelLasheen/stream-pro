import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_sheet_header.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_visibility_tile.dart';

class PlaylistEditResult {
  final String title;
  final String? description;
  final bool isPublic;

  const PlaylistEditResult({
    required this.title,
    this.description,
    required this.isPublic,
  });
}

class EditPlaylistSheet extends StatefulWidget {
  final PlaylistDetailsEntity playlist;

  const EditPlaylistSheet({super.key, required this.playlist});

  static Future<PlaylistEditResult?> show(
    BuildContext context, {
    required PlaylistDetailsEntity playlist,
  }) {
    return showModalBottomSheet<PlaylistEditResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditPlaylistSheet(playlist: playlist),
    );
  }

  @override
  State<EditPlaylistSheet> createState() => _EditPlaylistSheetState();
}

class _EditPlaylistSheetState extends State<EditPlaylistSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final ValueNotifier<bool> _isPublic = ValueNotifier<bool>(false);
  final ValueNotifier<String> _title = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.playlist.title);
    _descriptionController = TextEditingController(
      text: widget.playlist.description ?? '',
    );
    _isPublic.value = widget.playlist.isPublic;
    _title.value = widget.playlist.title;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _isPublic.dispose();
    _title.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty) {
      context.showErrorSnackBar(message: 'Please enter a playlist name.');
      return;
    }

    context.navigateBack(
      PlaylistEditResult(
        title: title,
        description: description.isEmpty ? null : description,
        isPublic: _isPublic.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.surfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlaylistSheetHeader(
                title: 'Edit playlist',
                titleSpacing: 20,
              ),
              20.verticalSpace,
              AppFormField(
                controller: _titleController,
                label: 'Name',
                hint: 'My playlist',
                prefixIcon: Icons.playlist_add_outlined,
                textInputAction: TextInputAction.next,
                onChanged: (value) => _title.value = value,
                onFieldSubmitted: (_) => _submit(),
              ),
              16.verticalSpace,
              AppFormField(
                controller: _descriptionController,
                label: 'Description (optional)',
                hint: 'What is this playlist about?',
                prefixIcon: Icons.notes_outlined,
                maxLines: 3,
                minLines: 2,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
              ),
              12.verticalSpace,
              PlaylistVisibilityTile(isPublic: _isPublic),
              24.verticalSpace,
              ValueListenableBuilder<String>(
                valueListenable: _title,
                builder: (context, title, _) => AppButton(
                  text: 'Save changes',
                  isEnabled: title.trim().isNotEmpty,
                  onPressed: _submit,
                  icon: const Icon(Icons.check),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
