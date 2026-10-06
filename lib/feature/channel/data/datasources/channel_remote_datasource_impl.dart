import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/channel_details_model.dart';
import '../models/channel_home_model.dart';
import '../models/paginated_channel_videos_model.dart';
import '../models/paginated_channel_playlists_model.dart';
import 'channel_remote_datasource.dart';

class ChannelRemoteDataSourceImpl implements ChannelRemoteDataSource {
  final ApiService _apiService;

  ChannelRemoteDataSourceImpl(this._apiService);

  @override
  Future<ChannelDetailsModel> getChannelDetails(String channelId) async {
    final response = await _apiService.get(
      ApiConstants.channelDetails(channelId),
    );
    final responseData = response.data as Map<String, dynamic>;
    return ChannelDetailsModel.fromJson(responseData);
  }

  @override
  Future<ChannelHomeModel> getChannelHome(String channelId) async {
    final response = await _apiService.get(ApiConstants.channelHome(channelId));
    final responseData = response.data as Map<String, dynamic>;
    return ChannelHomeModel.fromJson(responseData);
  }

  @override
  Future<PaginatedChannelVideosModel> getChannelVideos(
    String channelId, {
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await _apiService.get(
      ApiConstants.channelVideos(channelId),
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    final responseData = response.data as Map<String, dynamic>;
    return PaginatedChannelVideosModel.fromJson(responseData);
  }

  @override
  Future<PaginatedChannelPlaylistsModel> getChannelPlaylists(
    String channelId, {
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await _apiService.get(
      ApiConstants.channelPlaylists(channelId),
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    final responseData = response.data as Map<String, dynamic>;
    return PaginatedChannelPlaylistsModel.fromJson(responseData);
  }
}
