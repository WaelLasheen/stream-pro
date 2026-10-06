import 'package:equatable/equatable.dart';
import 'subscriber_entity.dart';

class PaginatedSubscribersEntity extends Equatable {
  final List<SubscriberEntity> items;
  final int pageNumber;
  final int pageSize;

  const PaginatedSubscribersEntity({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
  });

  PaginatedSubscribersEntity copyWith({List<SubscriberEntity>? items}) {
    return PaginatedSubscribersEntity(
      items: items ?? this.items,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  @override
  List<Object?> get props => [items, pageNumber, pageSize];
}
