import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_owner_videos_entity.dart';
import '../repositories/owner_channel_repository.dart';

class GetOwnerVideosUseCase {
  final OwnerChannelRepository repository;

  GetOwnerVideosUseCase(this.repository);

  Future<Either<Failure, PaginatedOwnerVideosEntity>> call({
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getOwnerVideos(pageNumber: pageNumber, pageSize: pageSize);
  }
}
