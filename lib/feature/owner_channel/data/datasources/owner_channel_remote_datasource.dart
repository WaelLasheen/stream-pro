import 'package:stream_pro/feature/owner_channel/data/models/paginated_subscribers_model.dart';

import '../models/owner_channel_model.dart';
import '../models/owner_playlist_model.dart';
import '../models/paginated_owner_videos_model.dart';

abstract class OwnerChannelRemoteDataSource {
  Future<OwnerChannelModel> getOwnerChannel();
  Future<void> createOwnerChannel();
  Future<void> updateChannelInfo({
    required String title,
    required String description,
  });
  Future<String> uploadChannelAvatar(String filePath);
  Future<String> uploadChannelThumbnail(String filePath);

  Future<PaginatedOwnerVideosModel> getOwnerVideos({
    required int pageNumber,
    required int pageSize,
  });
  Future<List<OwnerPlaylistModel>> getOwnerPlaylists();
  Future<PaginatedSubscribersModel> getSubscribers({
    required int pageNumber,
    required int pageSize,
  });
}
