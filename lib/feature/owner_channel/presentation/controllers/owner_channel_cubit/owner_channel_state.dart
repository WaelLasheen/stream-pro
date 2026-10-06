import 'package:equatable/equatable.dart';
import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';

sealed class OwnerChannelState extends Equatable {
  final OwnerChannelEntity? channel;

  const OwnerChannelState({this.channel});

  @override
  List<Object?> get props => [channel];
}

class OwnerChannelInitialState extends OwnerChannelState {
  const OwnerChannelInitialState();
}

class OwnerChannelLoadingState extends OwnerChannelState {
  const OwnerChannelLoadingState();
}

class OwnerChannelNoChannelState extends OwnerChannelState {
  const OwnerChannelNoChannelState();
}

class OwnerChannelLoadedState extends OwnerChannelState {
  const OwnerChannelLoadedState(OwnerChannelEntity channel)
    : super(channel: channel);
}

class OwnerChannelErrorState extends OwnerChannelState {
  final String message;

  const OwnerChannelErrorState({required this.message, super.channel});

  @override
  List<Object?> get props => [message, channel];
}
