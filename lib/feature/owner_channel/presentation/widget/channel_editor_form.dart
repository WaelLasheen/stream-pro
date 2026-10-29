import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/generated/l10n.dart';
import 'channel_image_picker.dart';

class ChannelEditorForm extends StatelessWidget {
  final OwnerChannelEntity? initialData;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueNotifier<String?> pickedAvatarNotifier;
  final ValueNotifier<String?> pickedThumbnailNotifier;
  final VoidCallback onPickAvatar;
  final VoidCallback onPickThumbnail;
  final bool isLoading;
  final VoidCallback onSubmit;
  final FocusNode descriptionFocusNode;

  const ChannelEditorForm({
    super.key,
    required this.initialData,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.pickedAvatarNotifier,
    required this.pickedThumbnailNotifier,
    required this.onPickAvatar,
    required this.onPickThumbnail,
    required this.isLoading,
    required this.onSubmit,
    required this.descriptionFocusNode,
  });

  bool get isEditMode => initialData != null;

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Form(
      key: formKey,
      child: Column(
        children: [
          // Everything (header + fields) scrolls together now
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: collapses when keyboard opens
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        height: isKeyboardVisible ? 150.h : 300.h,
                        child: ChannelCoverPicker(
                          networkUrl: initialData?.thumbnailUrl,
                          pickedPathNotifier: pickedThumbnailNotifier,
                          onTap: onPickThumbnail,
                        ),
                      ),
                      Positioned(
                        left: 16.r,
                        bottom: -32.r,
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: titleController,
                          builder: (context, titleValue, _) {
                            return ChannelAvatarPicker(
                              networkUrl: initialData?.channelImageUrl,
                              pickedPathNotifier: pickedAvatarNotifier,
                              fallbackText: titleValue.text,
                              onTap: onPickAvatar,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Compensate for the overlapping avatar half
                  SizedBox(height: 32.r + 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppFormField(
                          controller: titleController,
                          label: S.current.channelTitle,
                          hint: S.current.enterYourChannelName,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(
                              context,
                            ).requestFocus(descriptionFocusNode);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return S.current.titleIsRequired;
                            }
                            return null;
                          },
                        ),
                        24.verticalSpace,
                        AppFormField(
                          controller: descriptionController,
                          focusNode: descriptionFocusNode,
                          label: S.current.description,
                          hint: S.current.tellViewersAboutYourChannel,
                          textInputAction: TextInputAction.newline,
                          maxLines: 4,
                          minLines: 3,
                        ),
                        16.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom action bar
          Container(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: AppButton(
                text: isEditMode
                    ? S.current.updateChannel
                    : S.current.createChannel,
                isLoading: isLoading,
                onPressed: onSubmit,
                backgroundColor: const Color(0xFF6C5CE7),
                textColor: Colors.white,
                borderRadius: 16.r,
                fontSize: 16.sp,
                height: 56.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
