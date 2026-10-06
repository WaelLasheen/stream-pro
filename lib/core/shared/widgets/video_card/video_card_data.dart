enum VideoCardVariant { vertical, horizontal }

class VideoCardData {
  final String id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final int duration;
  final int views;
  final DateTime? publishedTime;
  final ChannelData? channel;

  const VideoCardData({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    this.publishedTime,
    this.channel,
  });
}

class ChannelData {
  final String id;
  final String name;
  final String avatarUrl;

  const ChannelData({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });
}
