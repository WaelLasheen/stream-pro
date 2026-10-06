import 'package:stream_pro/feature/subscriptions/domain/entities/paginated_subscriptions_entity.dart';
import 'subscription_model.dart';

class PaginatedSubscriptionsModel {
  final List<SubscriptionModel> subscriptions;
  final bool hasMore;
  final String? nextCursor;

  const PaginatedSubscriptionsModel({
    required this.subscriptions,
    required this.hasMore,
    this.nextCursor,
  });

  factory PaginatedSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    final list = json['subscriptions'] as List<dynamic>? ?? [];
    return PaginatedSubscriptionsModel(
      subscriptions: list
          .map((e) => SubscriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool? ?? false,
      nextCursor: json['nextCursor'] as String?,
    );
  }

  PaginatedSubscriptionsEntity toEntity() {
    return PaginatedSubscriptionsEntity(
      subscriptions: subscriptions.map((m) => m.toEntity()).toList(),
      hasMore: hasMore,
      nextCursor: nextCursor,
    );
  }
}
