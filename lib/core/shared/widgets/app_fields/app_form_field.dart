import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool? enabled;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? idleBorderColor;
  final void Function(String)? onChanged;
  final TextAlignVertical? textAlignVertical;

  const AppFormField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.enabled,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.fillColor,
    this.idleBorderColor,
    this.onChanged,
    this.textAlignVertical,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool _obscureText = true;

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isPassword = widget.isPassword;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMultiline = (widget.maxLines ?? 1) > 1;

    final fillColor =
        widget.fillColor ??
        (isDark ? appTheme.surfaceDark : appTheme.canvasLight);

    final idleBorder =
        widget.idleBorderColor ??
        (isDark ? appTheme.grey800 : appTheme.dividerMuted);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          8.verticalSpace,
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: widget.onChanged,
          keyboardType: isPassword
              ? TextInputType.visiblePassword
              : widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          obscureText: isPassword ? _obscureText : false,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          textAlignVertical:
              widget.textAlignVertical ??
              (isMultiline ? TextAlignVertical.top : null),
          style: context.textTheme.bodyMedium?.copyWith(
            color: appTheme.textPrimary,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: appTheme.textSecondaryShade500,
              fontSize: 15.sp,
            ),
            filled: true,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            border: _border(idleBorder, 1.w),
            enabledBorder: _border(idleBorder, 1.w),
            focusedBorder: _border(appTheme.primaryColor, 1.6.w),
            errorBorder: _border(appTheme.errorColorShade400, 1.w),
            focusedErrorBorder: _border(appTheme.errorColorShade400, 1.6.w),
            prefixIcon:
                widget.prefixWidget ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: appTheme.grey700,
                        size: 20.sp,
                      )
                    : (isPassword
                          ? Icon(
                              Icons.lock_outline,
                              color: appTheme.grey700,
                              size: 20.sp,
                            )
                          : null)),
            suffixIcon:
                widget.suffixWidget ??
                (isPassword
                    ? IconButton(
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: appTheme.grey700,
                          size: 20.sp,
                        ),
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
