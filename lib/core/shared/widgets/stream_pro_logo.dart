import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_pro/core/utils/consts/image_path.dart';

class StreamProLogo extends StatelessWidget {
  final double size;

  const StreamProLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.8,
      height: size,
      child: SvgPicture.asset(ImagePath.appLogo),
    );
  }
}
