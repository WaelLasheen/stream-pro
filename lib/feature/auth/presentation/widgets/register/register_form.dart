import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart'; // Adjust path if needed
import 'package:stream_pro/core/shared/widgets/app_fields/app_form_field.dart'; // Adjust path if needed
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/auth_validators.dart';
import 'package:stream_pro/feature/auth/presentation/widgets/register/terms_checkbox.dart';
import 'package:stream_pro/generated/l10n.dart';

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
          AppFormField(
            controller: nameController,
            focusNode: nameFocusNode,
            label: S.current.fullName,
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validateName,
            onFieldSubmitted: (_) => emailFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
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
            textInputAction: TextInputAction.next,
            validator: AuthValidators.validatePassword,
            onFieldSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
          ),
          SizedBox(height: 16.h),
          AppFormField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocusNode,
            label: S.current.confirmPassword,
            isPassword: true,
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
              return AppButton(
                text: S.current.signup,
                isLoading: isLoading,
                // Note: Since AppButton doesn't have an `isEnabled` property,
                // we pass a no-op function when terms are not accepted.
                onPressed: accepted ? _submit : () {},
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
