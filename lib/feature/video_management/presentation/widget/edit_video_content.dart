import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/shared/entity/category_entity.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/video_player/app_video_player.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/size_extension.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_cubit.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_state.dart';
import 'package:stream_pro/feature/video_management/domain/entities/managed_video_entity.dart';
import 'package:stream_pro/feature/video_management/presentation/mapper/video_player_mapper.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/edit_publish_card.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/edit_stats_row.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/edit_thumbnail_section.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form_controller.dart';
import 'package:stream_pro/generated/l10n.dart';

class EditVideoContent extends StatelessWidget {
  final ManagedVideoEntity video;
  final bool isBusy;
  final GlobalKey<FormState> formKey;
  final VideoInfoFormController form;
  final FilePickerService filePickerService;
  final VoidCallback onPickThumbnail;
  final ValueChanged<bool> onTogglePublish;
  final VoidCallback onSave;

  const EditVideoContent({
    super.key,
    required this.video,
    required this.isBusy,
    required this.formKey,
    required this.form,
    required this.filePickerService,
    required this.onPickThumbnail,
    required this.onTogglePublish,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: ListView(
            children: [
              if (video.hlsUrl != null)
                AppVideoPlayer(
                  key: ValueKey('video_${video.hlsUrl}'),
                  data: video.toVideoPlayerData(),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    EditStatsRow(video: video),
                    SizedBox(height: 16.h),

                    // Read from form.pendingThumbnailPath
                    EditThumbnailSection(
                      networkUrl:
                          video.thumbnailUrl ?? '', // Pass the original URL
                      pendingThumbnailPathNotifier:
                          form.pendingThumbnailPath, // Pass the notifier
                      isUploading: isBusy,
                      enabled: !isBusy,
                      onChange: onPickThumbnail,
                    ),
                    SizedBox(height: 16.h),

                    // Read from form.pendingIsPublished
                    ValueListenableBuilder<bool?>(
                      valueListenable: form.pendingIsPublished,
                      builder: (context, isPub, _) {
                        return EditPublishCard(
                          isPublished: isPub ?? video.isPublished,
                          isChanging: isBusy,
                          enabled: !isBusy,
                          onToggle: () =>
                              onTogglePublish(isPub ?? video.isPublished),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),

                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, catState) {
                        final categories = (catState is CategoryLoaded)
                            ? catState.categories
                                  .map(
                                    (e) =>
                                        CategoryEntity(id: e.id, name: e.name),
                                  )
                                  .toList()
                            : <CategoryEntity>[];

                        return VideoInfoForm(
                          controller: form,
                          categories: categories,
                          enabled: !isBusy,
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    AppButton(
                      text: S.current.saveChanges,
                      isLoading: isBusy,
                      onPressed: isBusy ? () {} : onSave,
                      height: 48.h,
                      borderRadius: 10.r,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isBusy)
          Container(
            height: context.screenHeight,
            width: context.screenWidth,
            color: context.appTheme.grey500.withValues(alpha: .5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
