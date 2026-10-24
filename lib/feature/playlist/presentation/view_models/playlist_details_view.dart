import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_state.dart';

class PlaylistDetailsView extends Equatable {
  final PlaylistDetailsEntity? playlist;
  final bool isLoading;
  final String? errorMessage;

  const PlaylistDetailsView({
    required this.playlist,
    required this.isLoading,
    this.errorMessage,
  });

  factory PlaylistDetailsView.from(PlaylistDetailsState state) {
    return PlaylistDetailsView(
      playlist: state.playlist,
      isLoading:
          state is PlaylistDetailsInitial || state is PlaylistDetailsLoading,
      errorMessage: state is PlaylistDetailsFailure ? state.errorMessage : null,
    );
  }

  List<PlaylistVideoEntity> get videos => playlist?.videos ?? const [];

  bool get hasFatalError => errorMessage != null && playlist == null;

  @override
  List<Object?> get props => [playlist, isLoading, errorMessage];
}
