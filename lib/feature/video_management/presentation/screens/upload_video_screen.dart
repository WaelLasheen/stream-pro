import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/core/theme/font_styles.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/video_management/domain/entities/upload_video_params.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/upload_video_cubit/upload_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/upload_video_cubit/upload_video_state.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/upload_video_content.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form_controller.dart';

class UploadVideoScreen extends StatefulWidget {
  final FilePickerService filePickerService;

  const UploadVideoScreen({super.key, required this.filePickerService});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _form = VideoInfoFormController();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.video,
    );
    if (path != null) {
      _form.selectedVideoFile.value = PlatformFile(
        name: path.split('/').last,
        path: path,
        size: 0, // Size isn't strictly needed for the UI tile
      );
    }
  }

  Future<void> _pickThumbnail() async {
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.image,
    );
    if (path != null && mounted) {
      _form.selectedThumbnailFile.value = PlatformFile(
        name: path.split('/').last,
        path: path,
        size: 0,
      );
    }
  }

  void _submitUpload() {
    if (!_formKey.currentState!.validate()) return;

    final videoPath = _form.selectedVideoFile.value?.path;
    if (videoPath == null) {
      context.showErrorSnackBar(message: 'Please select a video file');
      return;
    }

    final thumbnailPath = _form.selectedThumbnailFile.value?.path;
    if (thumbnailPath == null) {
      context.showErrorSnackBar(message: 'Please select a thumbnail image');
      return;
    }

    context.read<UploadVideoCubit>().uploadVideo(
      UploadVideoParams(
        initParams: _form.toInitParams(),
        videoFilePath: videoPath,
        thumbnailFilePath: thumbnailPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadVideoCubit, UploadVideoState>(
      listener: (context, state) {
        if (state is UploadVideoSuccess) {
          context.showSuccessSnackBar(message: 'Video uploaded successfully!');
          Navigator.pop(context, true);
        } else if (state is UploadVideoError) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is UploadVideoLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text('Upload Video', style: FontStyles.titleLarge),
            centerTitle: true,
          ),
          body: UploadVideoContent(
            formKey: _formKey,
            form: _form,
            isLoading: isLoading,
            onPickVideo: _pickVideo,
            onPickThumbnail: _pickThumbnail,
            onSubmit: _submitUpload,
          ),
        );
      },
    );
  }
}
