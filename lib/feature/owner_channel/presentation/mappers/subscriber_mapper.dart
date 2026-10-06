import 'package:stream_pro/core/shared/widgets/subscriber_card/subscriber_card_data.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/subscriber_entity.dart';

extension SubscriberMapper on SubscriberEntity {
  SubscriberCardData toSubscriberCardData() {
    return SubscriberCardData(
      name: name,
      description: email,
      subscribedAt: createdAt,
    );
  }
}
