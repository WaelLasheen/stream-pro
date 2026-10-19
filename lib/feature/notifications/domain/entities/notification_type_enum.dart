enum NotificationType {
  like('LIKE'),
  comment('COMMENT'),
  playlist('PLAYLIST'),
  subscription('SUBSCRIPTION'),
  reply('REPLY'),
  unknown('UNKNOWN');

  final String value;
  const NotificationType(this.value);

  static NotificationType fromString(String? type) {
    if (type == null) return NotificationType.unknown;
    return NotificationType.values.firstWhere(
      (e) => e.value.toUpperCase() == type.trim().toUpperCase(),
      orElse: () => NotificationType.unknown,
    );
  }
}
