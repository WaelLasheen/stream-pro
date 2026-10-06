import '../models/paginated_subscriptions_model.dart';

abstract class SubscriptionsRemoteDataSource {
  Future<void> subscribeToChannel(String channelId);
  Future<void> unsubscribeToChannel(String channelId);
  Future<PaginatedSubscriptionsModel> getSubscriptions({
    required List<String> cursor,
  });
}
