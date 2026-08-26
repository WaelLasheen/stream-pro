import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_password_field.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_primary_button.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_text_field.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/auth_validators.dart';
import 'package:stream_pro/feature/auth/presentation/screen/widgets/register/terms_checkbox.dart';
import 'package:stream_pro/generated/l10n.dart';

/// The register form: name, email, password, confirm password,
/// terms checkbox and the submit button.
///
/// The submit button stays disabled until the terms checkbox is checked;
/// that state lives in a [ValueNotifier] so only the button rebuilds.
class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final ValueNotifier<bool> termsAccepted;
  final bool isLoading;
  final ValueChanged<RegisterParams> onSubmit;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.termsAccepted,
    required this.isLoading,
    required this.onSubmit,
  });

  void _submit() {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    onSubmit(
      RegisterParams(
        name: nameController.text.trim(),
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
          AuthTextField(
            controller: nameController,
            focusNode: nameFocusNode,
            label: S.current.fullName,
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateName,
            onFieldSubmitted: (_) => emailFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
          AuthTextField(
            controller: emailController,
            focusNode: emailFocusNode,
            label: S.current.email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateEmail,
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
          AuthPasswordField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            label: S.current.password,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validatePassword,
            onFieldSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
          AuthPasswordField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocusNode,
            label: S.current.confirmPassword,
            textInputAction: TextInputAction.done,
            validator: (value) => AuthValidators.validateConfirmPassword(
              value,
              passwordController.text,
            ),
            onFieldSubmitted: (_) => _submit(),
          ),
          SizedBox(height: 12.h),
          TermsCheckbox(isChecked: termsAccepted),
          SizedBox(height: 20.h),
          ValueListenableBuilder<bool>(
            valueListenable: termsAccepted,
            builder: (context, accepted, _) {
              return AuthPrimaryButton(
                label: S.current.signup,
                isLoading: isLoading,
                isEnabled: accepted,
                onPressed: _submit,
              );
            },
          ),
        ],
      ),
    );
  }
}
