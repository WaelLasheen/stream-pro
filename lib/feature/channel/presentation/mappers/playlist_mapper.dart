import 'package:stream_pro/core/shared/widgets/playlist_card/playlist_card_data.dart';
import 'package:stream_pro/feature/channel/domain/entities/channel_playlist_entity.dart';

extension PlaylistMapper on ChannelPlaylistEntity {
  PlaylistCardData toVideoCardData() {
    return PlaylistCardData(
      id: id,
      title: title,
      description: description,
      thumbnails: thumbnails,
      videosCount: videosCount,
      isPublic: isPublic,
    );
  }
}
