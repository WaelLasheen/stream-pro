import 'package:flutter/material.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

import '../widgets/sessions_view.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.backgroundColor,
      appBar: AppBar(title: Text(S.current.currentSessionsTitle)),
      body: const SessionsView(),
    );
  }
}
