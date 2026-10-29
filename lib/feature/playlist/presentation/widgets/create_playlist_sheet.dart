import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_state.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_sheet_header.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_visibility_tile.dart';
import 'package:stream_pro/generated/l10n.dart';

class CreatePlaylistSheet extends StatefulWidget {
  final String videoId;

  const CreatePlaylistSheet({super.key, required this.videoId});

  static Future<VideoPlaylistEntity?> show(
    BuildContext context, {
    required String videoId,
  }) {
    return showModalBottomSheet<VideoPlaylistEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<CreatePlaylistCubit>(),
        child: CreatePlaylistSheet(videoId: videoId),
      ),
    );
  }

  @override
  State<CreatePlaylistSheet> createState() => _CreatePlaylistSheetState();
}

class _CreatePlaylistSheetState extends State<CreatePlaylistSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final ValueNotifier<bool> _isPublic = ValueNotifier<bool>(false);
  final ValueNotifier<String> _title = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
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
    if (title.isEmpty) {
      context.showErrorSnackBar(message: S.current.pleaseEnterPlaylistName);
      return;
    }

    context.read<CreatePlaylistCubit>().create(
      title: title,
      description: _descriptionController.text.trim(),
      isPublic: _isPublic.value,
      videoId: widget.videoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocConsumer<CreatePlaylistCubit, CreatePlaylistState>(
      listener: (context, state) {
        if (state is CreatePlaylistSuccess) {
          context.navigateBack(
            VideoPlaylistEntity(
              playlistId: state.playlistId,
              title: state.title,
              isPublic: state.isPublic,
              hasVideo: true,
            ),
          );
        } else if (state is CreatePlaylistFailure) {
          context.showErrorSnackBar(message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is CreatePlaylistLoading;

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
                  PlaylistSheetHeader(
                    title: S.current.createNewPlaylist,
                    titleSpacing: 20,
                  ),
                  20.verticalSpace,
                  AppFormField(
                    controller: _titleController,
                    label: S.current.name,
                    hint: S.current.myPlaylistHint,
                    prefixIcon: Icons.playlist_add_outlined,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _title.value = value,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  16.verticalSpace,
                  AppFormField(
                    controller: _descriptionController,
                    label: S.current.descriptionOptional,
                    hint: S.current.whatIsThisPlaylistAbout,
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
                      text: S.current.create,
                      isLoading: isLoading,
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
      },
    );
  }
}
