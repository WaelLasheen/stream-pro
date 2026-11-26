import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';

class StreamProLogo extends StatelessWidget {
  final double size;
  final double? width;

  const StreamProLogo({super.key, required this.size, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? size * 1.8,
      height: size,
      child: SvgPicture.asset(ImagePath.appLogo),
    );
  }
}
