import 'package:equatable/equatable.dart';
import '../../../domain/entities/managed_video_entity.dart';

sealed class EditVideoState extends Equatable {
  final ManagedVideoEntity? video;

  const EditVideoState({this.video});

  @override
  List<Object?> get props => [video];
}

class EditVideoInitial extends EditVideoState {
  const EditVideoInitial();
}

class EditVideoLoading extends EditVideoState {
  const EditVideoLoading({super.video});
}

class EditVideoLoaded extends EditVideoState {
  const EditVideoLoaded({required ManagedVideoEntity super.video});

  @override
  List<Object?> get props => [video];
}

class EditVideoUpdated extends EditVideoState {
  const EditVideoUpdated({required ManagedVideoEntity super.video});

  @override
  List<Object?> get props => [video];
}

class EditVideoError extends EditVideoState {
  final String message;

  const EditVideoError({required this.message, super.video});

  @override
  List<Object?> get props => [message, video];
}

class EditVideoDeleted extends EditVideoState {
  const EditVideoDeleted();
}
