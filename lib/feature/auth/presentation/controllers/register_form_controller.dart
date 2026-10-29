import 'package:flutter/material.dart';
import 'package:stream_pro/feature/auth/domain/use_case/register_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controllers/auth_form_controller.dart';

class RegisterFormController extends AuthFormController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final ValueNotifier<bool> termsAccepted = ValueNotifier<bool>(false);

  void focusEmail() {
    emailFocusNode.requestFocus();
  }

  void focusPassword() {
    passwordFocusNode.requestFocus();
  }

  void focusConfirmPassword() {
    confirmPasswordFocusNode.requestFocus();
  }

  RegisterParams? buildParams() {
    if (!validate() || !termsAccepted.value) return null;

    return RegisterParams(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    termsAccepted.dispose();
  }
}
