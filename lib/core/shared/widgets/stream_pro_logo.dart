import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';

class StreamProLogo extends StatelessWidget {
  final double size;

  const StreamProLogo({super.key, required this.size});

  static const Color playBlue = Color(0xFF2196F3);
  static const Color waveTeal = Color(0xFF1DE9B6);
  static const Color wavePurple = Color(0xFF8B5CF6);
  static const Color wavePink = Color(0xFFEC4899);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.8,
      height: size,
      child: SvgPicture.asset(ImagePath.appLogo),
    );
  }
}
