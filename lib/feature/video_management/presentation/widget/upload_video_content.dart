import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/entity/category_entity.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_cubit.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_state.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/file_picker_section.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form.dart';
import 'package:stream_pro/feature/video_management/presentation/widget/video_info_form_controller.dart';
import 'package:stream_pro/generated/l10n.dart';

class UploadVideoContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VideoInfoFormController form;
  final bool isLoading;
  final VoidCallback onPickVideo;
  final VoidCallback onPickThumbnail;
  final VoidCallback onSubmit;

  const UploadVideoContent({
    super.key,
    required this.formKey,
    required this.form,
    required this.isLoading,
    required this.onPickVideo,
    required this.onPickThumbnail,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        children: [
          // 1. Form Fields (Fetches categories dynamically)
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, catState) {
              final categories = (catState is CategoryLoaded)
                  ? catState.categories
                        .map((e) => CategoryEntity(id: e.id, name: e.name))
                        .toList()
                  : <CategoryEntity>[];

              return VideoInfoForm(
                controller: form,
                categories: categories,
                enabled: !isLoading,
              );
            },
          ),

          24.verticalSpace,

          // 2. Video File Picker
          FilePickerSection(
            title: S.current.videoFileRequired,
            fileNotifier: form.selectedVideoFile,
            isImage: false,
            icon: Icons.video_call_outlined,
            emptyTitle: S.current.tapToSelectVideo,
            emptySubtitle: S.current.videoFileFormats,
            enabled: !isLoading,
            onPick: onPickVideo,
            onClear: () => form.selectedVideoFile.value = null,
          ),

          24.verticalSpace,

          // 3. Thumbnail File Picker
          FilePickerSection(
            title: S.current.thumbnailImageRequired,
            fileNotifier: form.selectedThumbnailFile,
            isImage: true,
            icon: Icons.add_photo_alternate_outlined,
            emptyTitle: S.current.tapToSelectThumbnail,
            emptySubtitle: S.current.thumbnailImageFormats,
            enabled: !isLoading,
            onPick: onPickThumbnail,
            onClear: () => form.selectedThumbnailFile.value = null,
          ),

          32.verticalSpace,

          // 4. Submit Button
          AppButton(
            text: S.current.startUpload,
            isLoading: isLoading,
            onPressed: isLoading ? () {} : onSubmit,
            height: 48.h,
            borderRadius: 10.r,
          ),
        ],
      ),
    );
  }
}
