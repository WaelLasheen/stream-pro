import 'package:equatable/equatable.dart';

class WatchHistoryVideoEntity extends Equatable {
  final String id;
  final String title;
  final String? thumbnailUrl;
  final int durationSeconds;

  const WatchHistoryVideoEntity({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    required this.durationSeconds,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl, durationSeconds];
}
