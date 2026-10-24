import 'package:dio/dio.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/owner_channel/data/models/paginated_subscribers_model.dart';
import '../models/owner_channel_model.dart';
import '../models/owner_playlist_model.dart';
import '../models/paginated_owner_videos_model.dart';
import 'owner_channel_remote_datasource.dart';

class OwnerChannelRemoteDataSourceImpl implements OwnerChannelRemoteDataSource {
  final ApiService _apiService;

  OwnerChannelRemoteDataSourceImpl(this._apiService);

  @override
  Future<OwnerChannelModel> getOwnerChannel() async {
    final response = await _apiService.get(ApiConstants.ownerChannels);
    return OwnerChannelModel.fromJson(response.data);
  }

  @override
  Future<void> createOwnerChannel() async {
    await _apiService.post(ApiConstants.ownerChannels);
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
  Future<PaginatedOwnerVideosModel> getOwnerVideos({
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await _apiService.get(
      ApiConstants.ownerVideos,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    final responseData = response.data as Map<String, dynamic>;
    return PaginatedOwnerVideosModel.fromJson(responseData);
  }

  @override
  Future<List<OwnerPlaylistModel>> getOwnerPlaylists() async {
    final response = await _apiService.get(ApiConstants.ownerPlaylists);
    final List<dynamic> data = response.data as List<dynamic>? ?? [];
    return data
        .map((e) => OwnerPlaylistModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PaginatedSubscribersModel> getSubscribers({
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await _apiService.get(
      ApiConstants.subscribers,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    final data = response.data as Map<String, dynamic>;
    return PaginatedSubscribersModel.fromJson(data);
  }
}
