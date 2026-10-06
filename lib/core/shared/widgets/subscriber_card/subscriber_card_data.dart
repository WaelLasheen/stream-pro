class SubscriberCardData {
  final String name;
  final String description;
  final String? avatarUrl;
  final DateTime subscribedAt;

  const SubscriberCardData({
    required this.name,
    required this.description,
    this.avatarUrl,
    required this.subscribedAt,
  });
}
