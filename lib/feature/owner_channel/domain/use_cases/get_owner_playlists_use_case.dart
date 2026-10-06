import 'package:dartz/dartz.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import '../entities/owner_playlist_entity.dart';
import '../repositories/owner_channel_repository.dart';

class GetOwnerPlaylistsUseCase {
  final OwnerChannelRepository repository;

  GetOwnerPlaylistsUseCase(this.repository);

  Future<Either<Failure, List<OwnerPlaylistEntity>>> call() {
    return repository.getOwnerPlaylists();
  }
}
