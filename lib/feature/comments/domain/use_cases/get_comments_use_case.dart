import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/paginated_comments_entity.dart';
import '../repositories/comments_repository.dart';

class GetCommentsUseCase {
  final CommentsRepository repository;
  GetCommentsUseCase(this.repository);

  Future<Either<Failure, PaginatedCommentsEntity>> call({
    required String videoId,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getComments(videoId: videoId, page: page, limit: limit);
  }
}
