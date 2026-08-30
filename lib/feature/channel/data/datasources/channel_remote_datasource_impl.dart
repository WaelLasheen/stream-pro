import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/owner_channel_model.dart';
import '../models/channel_details_model.dart';
import '../models/channel_home_model.dart';
import '../models/paginated_channel_videos_model.dart';
import '../models/paginated_channel_playlists_model.dart';
import 'channel_remote_datasource.dart';

class ChannelRemoteDataSourceImpl implements ChannelRemoteDataSource {
  final ApiService _apiService;

  ChannelRemoteDataSourceImpl(this._apiService);

  @override
  Future<OwnerChannelModel> getOwnerChannel() async {
    final response = await _apiService.get(ApiConstants.ownerChannels);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return OwnerChannelModel.fromJson(data);
  }

  @override
  Future<OwnerChannelModel> createOwnerChannel() async {
    // POST request with no body parameters
    final response = await _apiService.post(ApiConstants.ownerChannels);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return OwnerChannelModel.fromJson(data);
  }

  @override
  Future<void> updateChannelInfo({
    required String title,
    required String description,
  }) async {
    await _apiService.patch(
      ApiConstants.ownerChannels,
      data: {'title': title, 'description': description},
    );
  }

  @override
  Future<String> uploadChannelAvatar(String filePath) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    final response = await _apiService.patch(
      ApiConstants.uploadChannelAvatar,
      data: formData,
    );
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return data['channelImageUrl'] as String;
  }

  @override
  Future<String> uploadChannelThumbnail(String filePath) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'thumbnail': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    final response = await _apiService.patch(
      ApiConstants.uploadChannelThumbnail,
      data: formData,
    );
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return data['thumbnailUrl'] as String;
  }

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
