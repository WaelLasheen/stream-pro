import 'package:flutter/material.dart';

abstract class AuthFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose();
}
