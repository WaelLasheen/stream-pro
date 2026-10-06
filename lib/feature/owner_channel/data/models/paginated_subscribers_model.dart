import 'package:stream_pro/feature/owner_channel/data/models/subscriber_model.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/paginated_subscribers_entity.dart';

class PaginatedSubscribersModel {
  final List<SubscriberModel> items;
  final int pageNumber;
  final int pageSize;

  const PaginatedSubscribersModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
  });

  factory PaginatedSubscribersModel.fromJson(Map<String, dynamic> json) {
    final list = json['items'] as List<dynamic>? ?? [];
    return PaginatedSubscribersModel(
      items: list
          .map((e) => SubscriberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );
  }

  PaginatedSubscribersEntity toEntity() {
    return PaginatedSubscribersEntity(
      items: items.map((m) => m.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
