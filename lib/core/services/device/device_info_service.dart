import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoData {
  final String deviceType;
  final String? deviceName;
  final String? appVersion;

  const DeviceInfoData({
    required this.deviceType,
    this.deviceName,
    this.appVersion,
  });
}

abstract class DeviceInfoService {
  Future<DeviceInfoData> getDeviceInfo();
}

class DeviceInfoServiceImpl implements DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo;

  Future<DeviceInfoData>? _cachedDeviceInfo;

  DeviceInfoServiceImpl({DeviceInfoPlugin? deviceInfo})
    : _deviceInfo = deviceInfo ?? DeviceInfoPlugin();

  @override
  Future<DeviceInfoData> getDeviceInfo() {
    return _cachedDeviceInfo ??= _loadDeviceInfo();
  }

  Future<DeviceInfoData> _loadDeviceInfo() async {
    final deviceType = _deviceType;
    final (appVersion, deviceName) = await (
      _readAppVersion(),
      _readDeviceNameSafely(),
    ).wait;

    return DeviceInfoData(
      deviceType: deviceType,
      deviceName: deviceName,
      appVersion: appVersion,
    );
  }

  String get _deviceType {
    if (kIsWeb) return 'WEB';

    return defaultTargetPlatform.name.toUpperCase();
  }

  Future<String?> _readDeviceName() async {
    if (kIsWeb) {
      final info = await _deviceInfo.webBrowserInfo;
      final browser = _browserName(info.browserName);

      return '$browser on ${_operatingSystem(info.platform, info.userAgent)}';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final info = await _deviceInfo.androidInfo;
        return _joinName([info.manufacturer, info.model]);
      case TargetPlatform.iOS:
        final info = await _deviceInfo.iosInfo;
        return _nonEmpty(info.modelName) ?? _nonEmpty(info.name);
      case TargetPlatform.macOS:
        final info = await _deviceInfo.macOsInfo;
        return _nonEmpty(info.computerName) ?? _nonEmpty(info.modelName);
      case TargetPlatform.windows:
        final info = await _deviceInfo.windowsInfo;
        return _nonEmpty(info.computerName);
      case TargetPlatform.linux:
        final info = await _deviceInfo.linuxInfo;
        return _nonEmpty(info.prettyName);
      case TargetPlatform.fuchsia:
        return null;
    }
  }

  Future<String?> _readDeviceNameSafely() async {
    try {
      return await _readDeviceName();
    } catch (_) {
      return null;
    }
  }

  Future<String?> _readAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return _nonEmpty(packageInfo.version);
    } catch (_) {
      return null;
    }
  }

  String _browserName(BrowserName browserName) {
    switch (browserName) {
      case BrowserName.firefox:
        return 'Firefox';
      case BrowserName.samsungInternet:
        return 'Samsung Internet';
      case BrowserName.opera:
        return 'Opera';
      case BrowserName.msie:
        return 'Internet Explorer';
      case BrowserName.edge:
        return 'Edge';
      case BrowserName.chrome:
        return 'Chrome';
      case BrowserName.safari:
        return 'Safari';
      case BrowserName.unknown:
        return 'Browser';
    }
  }

  String _operatingSystem(String? platform, String? userAgent) {
    final source = '${platform ?? ''} ${userAgent ?? ''}'.toLowerCase();

    if (source.contains('android')) return 'Android';
    if (source.contains('iphone') || source.contains('ipad')) return 'iOS';
    if (source.contains('win')) return 'Windows';
    if (source.contains('mac')) return 'macOS';
    if (source.contains('linux')) return 'Linux';

    return 'Unknown OS';
  }

  String? _joinName(List<String?> parts) {
    final name = parts
        .map((part) => part?.trim())
        .whereType<String>()
        .where((part) => part.isNotEmpty)
        .join(' ');

    return name.isEmpty ? null : name;
  }

  String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
