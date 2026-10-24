import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';

sealed class PlaylistDetailsState extends Equatable {
  final PlaylistDetailsEntity? playlist;
  const PlaylistDetailsState({this.playlist});

  @override
  List<Object?> get props => [playlist];
}

final class PlaylistDetailsInitial extends PlaylistDetailsState {
  const PlaylistDetailsInitial();
}

final class PlaylistDetailsLoading extends PlaylistDetailsState {
  const PlaylistDetailsLoading();
}

final class PlaylistDetailsLoaded extends PlaylistDetailsState {
  const PlaylistDetailsLoaded({required PlaylistDetailsEntity super.playlist});

  @override
  List<Object?> get props => [playlist];
}

final class PlaylistDetailsFailure extends PlaylistDetailsState {
  final String errorMessage;
  const PlaylistDetailsFailure({super.playlist, required this.errorMessage});

  @override
  List<Object?> get props => [playlist, errorMessage];
}

final class PlaylistDetailsDeleted extends PlaylistDetailsState {
  const PlaylistDetailsDeleted();
}
