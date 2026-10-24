import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/core/error/failures/failure.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_playlist_entity.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/get_owner_playlists_use_case.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_state.dart';

class _FakeOwnerChannelRepository implements OwnerChannelRepository {
  final List<OwnerPlaylistEntity> playlists;

  _FakeOwnerChannelRepository(this.playlists);

  @override
  Future<Either<Failure, List<OwnerPlaylistEntity>>> getOwnerPlaylists() async {
    return Right(playlists);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

OwnerPlaylistEntity _playlist(String id) {
  return OwnerPlaylistEntity(
    id: id,
    title: 'Playlist $id',
    isPublic: true,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('OwnerPlaylistsCubit', () {
    test(
      'silent refresh keeps the loaded list without a loading state',
      () async {
        final cubit = OwnerPlaylistsCubit(
          getOwnerPlaylistsUseCase: GetOwnerPlaylistsUseCase(
            _FakeOwnerChannelRepository([_playlist('p1')]),
          ),
        );

        await cubit.fetchOwnerPlaylists();
        expect(cubit.state, isA<OwnerPlaylistsLoadedState>());

        final states = <OwnerPlaylistsState>[];
        final subscription = cubit.stream.listen(states.add);

        await cubit.fetchOwnerPlaylists(showLoading: false);

        expect(states.whereType<OwnerPlaylistsLoadingState>(), isEmpty);
        expect(cubit.state, isA<OwnerPlaylistsLoadedState>());
        expect(
          (cubit.state as OwnerPlaylistsLoadedState).playlists.map(
            (playlist) => playlist.id,
          ),
          ['p1'],
        );

        await subscription.cancel();
        await cubit.close();
      },
    );
  });
}
