import '../models/channel_details_model.dart';
import '../models/channel_home_model.dart';
import '../models/paginated_channel_videos_model.dart';
import '../models/paginated_channel_playlists_model.dart';

abstract class ChannelRemoteDataSource {
  Future<ChannelDetailsModel> getChannelDetails(String channelId);
  Future<ChannelHomeModel> getChannelHome(String channelId);
  Future<PaginatedChannelVideosModel> getChannelVideos(
    String channelId, {
    required int pageNumber,
    required int pageSize,
  });
  Future<PaginatedChannelPlaylistsModel> getChannelPlaylists(
    String channelId, {
    required int pageNumber,
    required int pageSize,
  });
}
