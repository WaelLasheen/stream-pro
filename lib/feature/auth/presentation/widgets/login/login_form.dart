import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart'; // Adjust path if needed
import 'package:stream_pro/core/shared/widgets/app_form_field.dart'; // Adjust path if needed
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_validators.dart';
import 'package:stream_pro/generated/l10n.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final bool isLoading;
  final ValueChanged<LoginParams> onSubmit;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.isLoading,
    required this.onSubmit,
  });

  void _submit() {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    onSubmit(
      LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFormField(
            controller: emailController,
            focusNode: emailFocusNode,
            label: S.current.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateEmail,
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
          AppFormField(
            controller: passwordController,
            focusNode: passwordFocusNode,
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
            onPressed: _submit,
            height: 52.h,
            borderRadius: 16.r,
          ),
        ],
      ),
    );
  }
}
