import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
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

  const SessionEntity({
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

  bool get isActive {
    if (isRevoked) return false;
    final expiry = expiresAt;
    return expiry == null || expiry.isAfter(DateTime.now());
  }

  String? get ipAddress => lastIp ?? createdIp;

  @override
  List<Object?> get props => [
    id,
    deviceName,
    deviceType,
    appVersion,
    userAgent,
    city,
    country,
    lastIp,
    createdIp,
    loginMethod,
    createdAt,
    lastUsedAt,
    expiresAt,
    isRevoked,
  ];
}
