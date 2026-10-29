import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../domain/entities/session_entity.dart';
import '../../../../generated/l10n.dart';

extension SessionDisplay on SessionEntity {
  String deviceLabel(BuildContext context) {
    final name = deviceName?.trim();
    if (name != null && name.isNotEmpty) return name;

    final type = deviceType?.trim();
    if (type != null && type.isNotEmpty) return type;

    final agent = userAgent?.trim();
    if (agent != null && agent.isNotEmpty) return agent;

    return S.current.unknownDevice;
  }

  IconData get deviceIcon {
    final source = '${deviceType ?? ''} ${userAgent ?? ''}'.toLowerCase();

    if (source.contains('iphone') || source.contains('ios')) {
      return Icons.phone_iphone_rounded;
    }
    if (source.contains('ipad') || source.contains('tablet')) {
      return Icons.tablet_mac_rounded;
    }
    if (source.contains('android')) {
      return Icons.phone_android_rounded;
    }
    if (source.contains('windows')) {
      return Icons.desktop_windows_rounded;
    }
    if (source.contains('mac') || source.contains('linux')) {
      return Icons.laptop_mac_rounded;
    }
    return Icons.devices_other_rounded;
  }

  String loginMethodLabel(BuildContext context) {
    switch (loginMethod.toUpperCase()) {
      case 'LOCAL':
        return S.current.loginMethodLocal;
      case 'GOOGLE':
        return S.current.loginMethodGoogle;
      case 'APPLE':
        return S.current.loginMethodApple;
      default:
        return loginMethod;
    }
  }

  String? get locationLabel {
    final parts = <String>[
      if (city != null && city!.isNotEmpty) city!,
      if (country != null && country!.isNotEmpty) country!,
    ];
    return parts.isEmpty ? null : parts.join(' • ');
  }

  String? get lastActiveLabel {
    final lastUsed = lastUsedAt;
    if (lastUsed == null) return null;
    if (DateTime.now().difference(lastUsed).inMinutes < 5) {
      return S.current.activeNow;
    }
    return timeago.format(lastUsed);
  }
}
