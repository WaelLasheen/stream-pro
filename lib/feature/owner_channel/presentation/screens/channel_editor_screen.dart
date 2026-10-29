import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_state.dart';
import 'package:stream_pro/feature/owner_channel/presentation/widget/channel_editor_form.dart';
import 'package:stream_pro/generated/l10n.dart';

class ChannelEditorScreen extends StatefulWidget {
  final OwnerChannelEntity? initialData;
  final FilePickerService filePickerService;

  const ChannelEditorScreen({
    super.key,
    this.initialData,
    required this.filePickerService,
  });

  @override
  State<ChannelEditorScreen> createState() => _ChannelEditorScreenState();
}

class _ChannelEditorScreenState extends State<ChannelEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final ValueNotifier<String?> _pickedAvatar = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _pickedThumbnail = ValueNotifier<String?>(null);
  final FocusNode _descriptionFocusNode = FocusNode();
  bool get _isEditMode => widget.initialData != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialData?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialData?.description ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant ChannelEditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialData != widget.initialData) {
      _titleController.text = widget.initialData?.title ?? '';
      _descriptionController.text = widget.initialData?.description ?? '';
      _pickedAvatar.value = null;
      _pickedThumbnail.value = null;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pickedAvatar.dispose();
    _pickedThumbnail.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.image,
    );

    if (path != null && mounted) {
      _pickedAvatar.value = path;
    }
  }

  Future<void> _pickThumbnail() async {
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.image,
    );

    if (path != null && mounted) {
      _pickedThumbnail.value = path;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<OwnerChannelCubit>();
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (_isEditMode) {
      await cubit.updateChannelDetails(
        title: title,
        description: description,
        avatarPath: _pickedAvatar.value,
        thumbnailPath: _pickedThumbnail.value,
      );
    } else {
      await cubit.createAndSetupChannel(
        title: title,
        description: description.isEmpty ? null : description,
        avatarPath: _pickedAvatar.value,
        thumbnailPath: _pickedThumbnail.value,
      );
    }

    if (!mounted) return;

    final state = cubit.state;
    if (state is OwnerChannelErrorState) {
      context.showErrorSnackBar(message: state.message);
      return;
    }

    if (state is OwnerChannelLoadedState) {
      context.showSuccessSnackBar(
        message: _isEditMode
            ? S.current.channelUpdatedSuccessfully
            : S.current.channelCreatedSuccessfully,
      );
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerChannelCubit, OwnerChannelState>(
      builder: (context, state) {
        final isLoading = state is OwnerChannelLoadingState;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: ChannelEditorForm(
            initialData: widget.initialData,
            formKey: _formKey,
            titleController: _titleController,
            descriptionController: _descriptionController,
            pickedAvatarNotifier: _pickedAvatar,
            pickedThumbnailNotifier: _pickedThumbnail,
            onPickAvatar: _pickAvatar,
            onPickThumbnail: _pickThumbnail,
            isLoading: isLoading,
            onSubmit: _submit,
            descriptionFocusNode: _descriptionFocusNode,
          ),
        );
      },
    );
  }
}
