import 'package:equatable/equatable.dart';
import '../../../domain/entities/channel_details_entity.dart';

sealed class ChannelDetailsState extends Equatable {
  const ChannelDetailsState();

  @override
  List<Object?> get props => [];
}

class ChannelDetailsInitialState extends ChannelDetailsState {
  const ChannelDetailsInitialState();
}

class ChannelDetailsLoadingState extends ChannelDetailsState {
  const ChannelDetailsLoadingState();
}

class ChannelDetailsLoadedState extends ChannelDetailsState {
  final ChannelDetailsEntity details;

  const ChannelDetailsLoadedState({required this.details});

  @override
  List<Object?> get props => [details];
}

class ChannelDetailsErrorState extends ChannelDetailsState {
  final String message;

  const ChannelDetailsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}