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
  final double? completionRate;
  final int? watchedSeconds;

  const VideoCardData({
    required this.id,
    required this.title,
    this.description,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    this.publishedTime,
    this.channel,
    this.completionRate,
    this.watchedSeconds,
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
