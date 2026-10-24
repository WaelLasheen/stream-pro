import 'package:equatable/equatable.dart';

sealed class CreatePlaylistState extends Equatable {
  const CreatePlaylistState();

  @override
  List<Object?> get props => [];
}

final class CreatePlaylistInitial extends CreatePlaylistState {
  const CreatePlaylistInitial();
}

final class CreatePlaylistLoading extends CreatePlaylistState {
  const CreatePlaylistLoading();
}

final class CreatePlaylistSuccess extends CreatePlaylistState {
  final String playlistId;
  final String title;
  final bool isPublic;

  const CreatePlaylistSuccess({
    required this.playlistId,
    required this.title,
    required this.isPublic,
  });

  @override
  List<Object?> get props => [playlistId, title, isPublic];
}

final class CreatePlaylistFailure extends CreatePlaylistState {
  final String errorMessage;

  const CreatePlaylistFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
