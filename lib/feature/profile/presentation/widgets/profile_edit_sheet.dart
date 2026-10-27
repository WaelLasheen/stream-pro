import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/snack_bar_extension.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';
import 'package:stream_pro/generated/l10n.dart';

class ProfileEditSheet extends StatefulWidget {
  final ProfileEntity profile;
  final FilePickerService filePickerService;

  const ProfileEditSheet({
    super.key,
    required this.profile,
    required this.filePickerService,
  });

  @override
  State<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<ProfileEditSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final ValueNotifier<String?> _pickedAvatarPath = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _isPickingImage = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pickedAvatarPath.dispose();
    _isPickingImage.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    _isPickingImage.value = true;
    final path = await widget.filePickerService.pickFile(
      type: AppFileType.image,
    );
    if (!mounted) return;
    _isPickingImage.value = false;
    if (path != null) _pickedAvatarPath.value = path;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ProfileCubit>().updateProfile(
      name: _nameController.text,
      avatarPath: _pickedAvatarPath.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous is ProfileLoaded &&
          previous.isSaving &&
          current is ProfileLoaded &&
          !current.isSaving,
      listener: (context, _) {
        context.showSuccessSnackBar(
          message: S.current.profileUpdatedSuccessfully,
        );
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: appTheme.surfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 36.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: appTheme.grey500,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      S.current.editProfilePage,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: appTheme.textPrimary,
                      ),
                    ),
                    24.verticalSpace,
                    Center(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isPickingImage,
                        builder: (context, isPickingImage, _) {
                          return ValueListenableBuilder<String?>(
                            valueListenable: _pickedAvatarPath,
                            builder: (context, pickedAvatarPath, _) {
                              return GestureDetector(
                                onTap: isPickingImage ? null : _pickAvatar,
                                child: Stack(
                                  children: [
                                    if (pickedAvatarPath != null)
                                      CircleAvatar(
                                        radius: 48.r,
                                        backgroundImage: FileImage(
                                          File(pickedAvatarPath),
                                        ),
                                      )
                                    else
                                      AppCircleNetworkImage(
                                        imageUrl:
                                            widget.profile.avatarUrl ?? '',
                                        radius: 48.r,
                                        fallbackText: widget.profile.name,
                                      ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 30.r,
                                        height: 30.r,
                                        decoration: BoxDecoration(
                                          color: appTheme.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: appTheme.surfaceColor,
                                            width: 2.w,
                                          ),
                                        ),
                                        child: isPickingImage
                                            ? Padding(
                                                padding: EdgeInsets.all(7.r),
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2.w,
                                                      color: appTheme.onPrimary,
                                                    ),
                                              )
                                            : Icon(
                                                Icons.camera_alt_rounded,
                                                size: 15.r,
                                                color: appTheme.onPrimary,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      S.current.changePhoto,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: appTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    24.verticalSpace,
                    AppFormField(
                      controller: _nameController,
                      label: S.current.fullName,
                      prefixIcon: Icons.person_outline_rounded,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _save(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return S.current.fullNameReq;
                        }
                        return null;
                      },
                    ),
                    24.verticalSpace,
                    BlocSelector<ProfileCubit, ProfileState, bool>(
                      selector: (state) {
                        return state is ProfileLoaded && state.isSaving;
                      },
                      builder: (context, isSaving) {
                        return Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: S.current.cancel,
                                isPrimary: false,
                                isFullWidth: false,
                                width: double.infinity,
                                borderRadius: 14.r,
                                onPressed: () {
                                  if (isSaving) Navigator.of(context).pop();
                                },
                                textColor: appTheme.grey800,
                                border: BorderSide(color: appTheme.grey500),
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: AppButton(
                                text: S.current.saveChanges,
                                isLoading: isSaving,
                                isFullWidth: false,
                                width: double.infinity,
                                borderRadius: 14.r,
                                onPressed: _save,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
