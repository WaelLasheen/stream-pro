import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controllers/login_form_controller.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_validators.dart';
import 'package:stream_pro/generated/l10n.dart';

class LoginForm extends StatelessWidget {
  final LoginFormController controller;
  final bool isLoading;
  final bool isEnabled;
  final ValueChanged<LoginParams> onSubmit;

  const LoginForm({
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
            textInputAction: TextInputAction.done,
            validator: AuthValidators.validatePassword,
            onFieldSubmitted: (_) => _submit(),
          ),
          SizedBox(height: 28.h),
          AppButton(
            text: S.current.login,
            isLoading: isLoading,
            isEnabled: isEnabled,
            onPressed: _submit,
            height: 52.h,
            borderRadius: 16.r,
          ),
        ],
      ),
    );
  }
}
