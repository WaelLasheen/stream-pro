import 'package:equatable/equatable.dart';
import '../../../domain/entities/paginated_channel_playlists_entity.dart';

sealed class ChannelPlaylistsState extends Equatable {
  final PaginatedChannelPlaylistsEntity? playlists;

  const ChannelPlaylistsState({this.playlists});

  @override
  List<Object?> get props => [playlists];
}

class ChannelPlaylistsInitialState extends ChannelPlaylistsState {
  const ChannelPlaylistsInitialState();
}

class ChannelPlaylistsLoadingState extends ChannelPlaylistsState {
  const ChannelPlaylistsLoadingState();
}

class ChannelPlaylistsLoadedState extends ChannelPlaylistsState {
  final bool isLoadingMore;

  const ChannelPlaylistsLoadedState({
    required PaginatedChannelPlaylistsEntity super.playlists,
    this.isLoadingMore = false,
  });

  ChannelPlaylistsLoadedState copyWith({
    PaginatedChannelPlaylistsEntity? playlists,
    bool? isLoadingMore,
  }) {
    return ChannelPlaylistsLoadedState(
      playlists: playlists ?? this.playlists!,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [playlists, isLoadingMore];
}

class ChannelPlaylistsErrorState extends ChannelPlaylistsState {
  final String message;

  const ChannelPlaylistsErrorState({required this.message, super.playlists});

  @override
  List<Object?> get props => [message, playlists];
}
