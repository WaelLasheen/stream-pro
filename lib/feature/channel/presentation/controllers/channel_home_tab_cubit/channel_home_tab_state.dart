import 'package:equatable/equatable.dart';
import '../../../domain/entities/channel_home_entity.dart';

sealed class ChannelHomeTabState extends Equatable {
  const ChannelHomeTabState();

  @override
  List<Object?> get props => [];
}

class ChannelHomeTabInitialState extends ChannelHomeTabState {
  const ChannelHomeTabInitialState();
}

class ChannelHomeTabLoadingState extends ChannelHomeTabState {
  const ChannelHomeTabLoadingState();
}

class ChannelHomeTabLoadedState extends ChannelHomeTabState {
  final ChannelHomeEntity home;

  const ChannelHomeTabLoadedState({required this.home});

  @override
  List<Object?> get props => [home];
}

class ChannelHomeTabErrorState extends ChannelHomeTabState {
  final String message;

  const ChannelHomeTabErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}