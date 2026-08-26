import 'dart:ui';
import 'package:flutter/material.dart';

extension OpacityExtension on Widget {
  Widget withOpacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  Widget withBlur(double sigma) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: this,
    );
  }
}
