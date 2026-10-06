import 'package:equatable/equatable.dart';
import '../../../domain/entities/owner_playlist_entity.dart';

sealed class OwnerPlaylistsState extends Equatable {
  const OwnerPlaylistsState();

  @override
  List<Object?> get props => [];
}

class OwnerPlaylistsInitialState extends OwnerPlaylistsState {
  const OwnerPlaylistsInitialState();
}

class OwnerPlaylistsLoadingState extends OwnerPlaylistsState {
  const OwnerPlaylistsLoadingState();
}

class OwnerPlaylistsLoadedState extends OwnerPlaylistsState {
  final List<OwnerPlaylistEntity> playlists;

  const OwnerPlaylistsLoadedState({required this.playlists});

  @override
  List<Object?> get props => [playlists];
}

class OwnerPlaylistsErrorState extends OwnerPlaylistsState {
  final String message;

  const OwnerPlaylistsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
