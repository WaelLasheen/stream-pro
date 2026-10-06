import 'package:equatable/equatable.dart';

abstract class VideoTrackState extends Equatable {
  const VideoTrackState();

  @override
  List<Object?> get props => [];
}

class VideoTrackInitial extends VideoTrackState {}

class VideoTrackUpdating extends VideoTrackState {}

class VideoTrackSuccess extends VideoTrackState {}

class VideoTrackFailure extends VideoTrackState {
  final String message;
  const VideoTrackFailure(this.message);

  @override
  List<Object?> get props => [message];
}
