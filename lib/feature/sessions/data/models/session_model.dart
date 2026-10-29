import '../../domain/entities/session_entity.dart';

class SessionModel {
  final String id;
  final String? deviceName;
  final String? deviceType;
  final String? appVersion;
  final String? userAgent;
  final String? city;
  final String? country;
  final String? lastIp;
  final String? createdIp;
  final String loginMethod;
  final DateTime? createdAt;
  final DateTime? lastUsedAt;
  final DateTime? expiresAt;
  final bool isRevoked;

  const SessionModel({
    required this.id,
    this.deviceName,
    this.deviceType,
    this.appVersion,
    this.userAgent,
    this.city,
    this.country,
    this.lastIp,
    this.createdIp,
    required this.loginMethod,
    this.createdAt,
    this.lastUsedAt,
    this.expiresAt,
    this.isRevoked = false,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      deviceName: _readString(json['deviceName']),
      deviceType: _readString(json['deviceType']),
      appVersion: _readString(json['appVersion']),
      userAgent: _readString(json['userAgent']),
      city: _decodeValue(json['city']),
      country: _decodeValue(json['country'])?.toUpperCase(),
      lastIp: _readString(json['lastIp']),
      createdIp: _readString(json['createdIp']),
      loginMethod: _readString(json['loginMethod']) ?? 'UNKNOWN',
      createdAt: _readDate(json['createdAt']),
      lastUsedAt: _readDate(json['lastUsedAt']),
      expiresAt: _readDate(json['expiresAt']),
      isRevoked: json['isRevoked'] as bool? ?? false,
    );
  }

  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      deviceName: deviceName,
      deviceType: deviceType,
      appVersion: appVersion,
      userAgent: userAgent,
      city: city,
      country: country,
      lastIp: lastIp,
      createdIp: createdIp,
      loginMethod: loginMethod,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
      expiresAt: expiresAt,
      isRevoked: isRevoked,
    );
  }

  static String? _readString(dynamic value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String? _decodeValue(dynamic value) {
    final raw = _readString(value);
    if (raw == null) return null;
    try {
      return Uri.decodeComponent(raw);
    } catch (_) {
      return raw;
    }
  }

  static DateTime? _readDate(dynamic value) {
    if (value is! String) return null;
    return DateTime.tryParse(value);
  }
}
