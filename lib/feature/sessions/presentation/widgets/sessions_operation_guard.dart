import 'package:flutter/material.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/generated/l10n.dart';

class SessionsOperationGuard extends StatelessWidget {
  final bool isBlocking;
  final Widget child;

  const SessionsOperationGuard({
    super.key,
    required this.isBlocking,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return PopScope(
      canPop: !isBlocking,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (isBlocking)
            Positioned.fill(
              child: ModalBarrier(
                dismissible: false,
                color: Colors.black.withValues(alpha: 0.48),
              ),
            ),
          if (isBlocking)
            Center(
              child: Material(
                color: appTheme.surfaceColor,
                borderRadius: BorderRadius.circular(18),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: appTheme.primaryColor),
                      const SizedBox(height: 18),
                      Text(
                        S.current.logoutAllDevices,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: appTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
