import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/video_details/domain/entities/video_entity.dart';

sealed class VideoDetailsState extends Equatable {
  const VideoDetailsState();

  @override
  List<Object?> get props => [];
}

final class VideoDetailsInitial extends VideoDetailsState {}

final class VideoDetailsLoading extends VideoDetailsState {}

final class VideoDetailsSuccess extends VideoDetailsState {
  final VideoEntity video;

  const VideoDetailsSuccess(this.video);

  @override
  List<Object?> get props => [video];
}

final class VideoDetailsFailure extends VideoDetailsState {
  final String errorMessage;

  const VideoDetailsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}