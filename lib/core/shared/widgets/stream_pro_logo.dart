import 'dart:math';

import 'package:flutter/material.dart';

/// Logo built 100% from Flutter widgets (no image assets):
/// a blue play triangle + a rotated wifi icon whose arcs are
/// tinted with the brand gradient (teal -> purple -> pink).
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ▶ Play triangle
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Icon(Icons.play_arrow_rounded, color: playBlue, size: size),
          ),

          // Gradient waves: wifi icon rotated 90° so the arcs
          // radiate to the right, tinted by a gradient shader.
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [waveTeal, wavePurple, wavePink],
              ).createShader(rect),
              child: Transform.rotate(
                angle: pi / 2,
                child: Icon(
                  Icons.wifi_rounded,
                  color: Colors.white,
                  size: size,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
