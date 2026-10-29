import 'package:flutter/material.dart';
import 'package:stream_pro/feature/auth/domain/use_case/login_use_case.dart';
import 'package:stream_pro/feature/auth/presentation/controllers/auth_form_controller.dart';

class LoginFormController extends AuthFormController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void focusPassword() {
    passwordFocusNode.requestFocus();
  }

  LoginParams? buildParams() {
    if (!validate()) return null;

    return LoginParams(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
