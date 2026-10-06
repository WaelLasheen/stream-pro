import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_data.dart';
import 'package:stream_pro/feature/subscriptions/domain/entities/subscription_entity.dart';

extension SubscriptionMapper on SubscriptionEntity {
  SubscriberCardData toSubscriberCardData() {
    return SubscriberCardData(
      name: channel.title,
      description: channel.description ?? channel.title,
      avatarUrl: channel.thumbnailUrl,
      subscribedAt: createdAt,
    );
  }
}
