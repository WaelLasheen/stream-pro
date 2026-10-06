import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/core/utils/extensions/dialog_extension.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_management/domain/entities/managed_video_entity.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_state.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/edit_loading_or_error_state.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/edit_video_content.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form_controller.dart';

class EditVideoScreen extends StatefulWidget {
  final String videoId;
  final FilePickerService filePickerService;

  const EditVideoScreen({
    super.key,
    required this.videoId,
    required this.filePickerService,
  });

  @override
  State<EditVideoScreen> createState() => _EditVideoScreenState();
}

class _EditVideoScreenState extends State<EditVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _form = VideoInfoFormController();
  bool _filled = false;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _onState(BuildContext context, EditVideoState state) {
    final video = state.video;
    if (!_filled && video != null) {
      _filled = true;
      _form.fill(video);
    } else if (video != null) {
      _form.pendingThumbnailPath.value = null;
      _form.pendingIsPublished.value = null;
    }

    if (state is EditVideoError) {
      context.showErrorSnackBar(message: state.message);
    } else if (state is EditVideoDeleted) {
      context.showSuccessSnackBar(message: 'Video deleted successfully');
      context.navigateBack(true);
    } else if (state is EditVideoUpdated) {
      context.showSuccessSnackBar(message: 'Video updated successfully');
      context.navigateBack(true);
    }
  }

  Future<void> _changeThumbnail() async {
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.image,
    );
    if (path != null) {
      _form.pendingThumbnailPath.value = path;
    }
  }

  void _togglePublish(bool currentIsPublished) {
    _form.pendingIsPublished.value = !currentIsPublished;
  }

  void _save(ManagedVideoEntity video) {
    if (!_formKey.currentState!.validate()) return;

    context.read<EditVideoCubit>().update(
      params: _form.toUpdateParams(),
      isPublic: _form.pendingIsPublished.value ?? video.isPublished,
      thumbnailPath: _form.pendingThumbnailPath.value,
    );
  }

  Future<void> _confirmDelete() async {
    final confirmed = await context.showDeleteConfirmationDialog();

    if (confirmed == true && mounted) {
      await context.read<EditVideoCubit>().deleteVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditVideoCubit, EditVideoState>(
      listener: _onState,
      builder: (context, state) {
        final isBusy = state is EditVideoLoading;
        final video = state.video;

        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Video', style: FontStyles.titleLarge),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: 'Delete video',
                icon: const Icon(Icons.delete_outline),
                onPressed: (video == null || isBusy) ? null : _confirmDelete,
              ),
            ],
          ),
          body: video == null
              ? EditLoadingOrErrorState(state: state, videoId: widget.videoId)
              : EditVideoContent(
                  video: video,
                  isBusy: isBusy,
                  formKey: _formKey,
                  form: _form,
                  filePickerService: widget.filePickerService,
                  onPickThumbnail: _changeThumbnail,
                  onTogglePublish: _togglePublish,
                  onSave: () => _save(video),
                ),
        );
      },
    );
  }
}
