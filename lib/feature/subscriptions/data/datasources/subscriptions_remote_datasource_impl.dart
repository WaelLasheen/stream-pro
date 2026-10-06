import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/paginated_subscriptions_model.dart';
import 'subscriptions_remote_datasource.dart';

class SubscriptionsRemoteDataSourceImpl
    implements SubscriptionsRemoteDataSource {
  final ApiService _apiService;

  SubscriptionsRemoteDataSourceImpl(this._apiService);

  @override
  Future<void> subscribeToChannel(String channelId) async {
    await _apiService.post(ApiConstants.subscription(channelId));
  }

  @override
  Future<void> unsubscribeToChannel(String channelId) async {
    await _apiService.delete(ApiConstants.subscription(channelId));
  }



  @override
  Future<PaginatedSubscriptionsModel> getSubscriptions({
    required List<String> cursor,
  }) async {
    final response = await _apiService.get(
      ApiConstants.subscriptions,
      queryParameters: {if (cursor.isNotEmpty) 'cursor': cursor.join(',')},
    );
    final data = response.data as Map<String, dynamic>;
    return PaginatedSubscriptionsModel.fromJson(data);
  }
}
