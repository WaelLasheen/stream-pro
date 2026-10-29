import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controllers/register_form_controller.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_validators.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/register/terms_checkbox.dart';
import 'package:stream_pro/generated/l10n.dart';

class RegisterForm extends StatelessWidget {
  final RegisterFormController controller;
  final bool isLoading;
  final bool isEnabled;
  final ValueChanged<RegisterParams> onSubmit;

  const RegisterForm({
    super.key,
    required this.controller,
    required this.isLoading,
    this.isEnabled = true,
    required this.onSubmit,
  });

  void _submit() {
    final params = controller.buildParams();
    if (params == null) return;

    onSubmit(params);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFormField(
            controller: controller.nameController,
            focusNode: controller.nameFocusNode,
            label: S.current.fullName,
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateName,
            onFieldSubmitted: (_) => controller.focusEmail(),
          ),
          SizedBox(height: 16.h),
          AppFormField(
            controller: controller.emailController,
            focusNode: controller.emailFocusNode,
            label: S.current.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateEmail,
            onFieldSubmitted: (_) => controller.focusPassword(),
          ),
          SizedBox(height: 16.h),
          AppFormField(
            controller: controller.passwordController,
            focusNode: controller.passwordFocusNode,
            label: S.current.password,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validatePassword,
            onFieldSubmitted: (_) => controller.focusConfirmPassword(),
          ),
          SizedBox(height: 16.h),
          AppFormField(
            controller: controller.confirmPasswordController,
            focusNode: controller.confirmPasswordFocusNode,
            label: S.current.confirmPassword,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (value) => AuthValidators.validateConfirmPassword(
              value,
              controller.passwordController.text,
            ),
            onFieldSubmitted: (_) => _submit(),
          ),
          SizedBox(height: 12.h),
          TermsCheckbox(isChecked: controller.termsAccepted),
          SizedBox(height: 20.h),
          ValueListenableBuilder<bool>(
            valueListenable: controller.termsAccepted,
            builder: (context, accepted, _) {
              return AppButton(
                text: S.current.signup,
                isLoading: isLoading,
                isEnabled: isEnabled && accepted,
                onPressed: _submit,
                height: 52.h,
                borderRadius: 16.r,
              );
            },
          ),
        ],
      ),
    );
  }
}
