import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

/// Password field with a show/hide toggle.
///
/// The visibility state is kept in a [ValueNotifier] and only the suffix
/// icon + obscure flag rebuild through [ValueListenableBuilder], so the
/// rest of the screen is never rebuilt when the eye icon is tapped.
class AuthPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;

  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  final ValueNotifier<bool> _obscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _obscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: _obscure,
      builder: (context, isObscured, _) {
        return TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: isObscured,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          keyboardType: TextInputType.visiblePassword,
          style: context.textTheme.bodyLarge?.copyWith(
            color: appTheme.textPrimary,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: appTheme.grey700,
              size: 20.sp,
            ),
            suffixIcon: IconButton(
              onPressed: () => _obscure.value = !_obscure.value,
              icon: Icon(
                isObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: appTheme.grey700,
                size: 20.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
