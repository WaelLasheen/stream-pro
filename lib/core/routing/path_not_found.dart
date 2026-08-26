import 'package:flutter/material.dart';
import 'package:stream_pro/generated/l10n.dart';

class PathNotFound extends StatelessWidget {
  const PathNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(S.current.pathNotFound)));
  }
}
