import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_data.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_playlist_entity.dart';

extension OwnerPlaylistMapper on OwnerPlaylistEntity {
  PlaylistCardData toVideoCardData() {
    return PlaylistCardData(
      id: id,
      title: title,
      description: description,
      thumbnails: thumbnails,
      videosCount: videoCount,
      isPublic: isPublic,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
