import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_channel_playlists_use_case.dart';
import 'channel_playlists_state.dart';

class ChannelPlaylistsCubit extends Cubit<ChannelPlaylistsState> {
  final GetChannelPlaylistsUseCase getChannelPlaylistsUseCase;

  ChannelPlaylistsCubit({required this.getChannelPlaylistsUseCase})
    : super(const ChannelPlaylistsInitialState());

  Future<void> fetchChannelPlaylists(String channelId) async {
    emit(const ChannelPlaylistsLoadingState());

    final result = await getChannelPlaylistsUseCase(channelId, pageNumber: 1);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ChannelPlaylistsErrorState(message: failure.message)),
      (playlists) => emit(ChannelPlaylistsLoadedState(playlists: playlists)),
    );
  }

  Future<void> loadMorePlaylists(String channelId) async {
    final currentState = state;
    final currentPlaylists = currentState.playlists;

    if (currentPlaylists == null || !currentPlaylists.hasNextPage) return;

    if (currentState is ChannelPlaylistsLoadedState &&
        currentState.isLoadingMore) {
      return;
    }

    emit(
      ChannelPlaylistsLoadedState(
        playlists: currentPlaylists,
        isLoadingMore: true,
      ),
    );

    final nextPage = currentPlaylists.pageNumber + 1;
    final result = await getChannelPlaylistsUseCase(
      channelId,
      pageNumber: nextPage,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ChannelPlaylistsErrorState(
          message: failure.message,
          playlists: currentPlaylists,
        ),
      ),
      (newPlaylists) => emit(
        ChannelPlaylistsLoadedState(
          playlists: newPlaylists.copyWith(
            items: [...currentPlaylists.items, ...newPlaylists.items],
          ),
          isLoadingMore: false,
        ),
      ),
    );
  }
}
