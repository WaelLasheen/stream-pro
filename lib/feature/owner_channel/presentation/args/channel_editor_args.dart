import 'package:stream_pro/feature/owner_channel/domain/entities/owner_channel_entity.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';

class ChannelEditorArgs {
  final OwnerChannelCubit cubit;
  final OwnerChannelEntity? channel;

  const ChannelEditorArgs({required this.cubit, this.channel});

  bool get hasAvatar =>
      channel != null &&
      channel!.channelImageUrl != null &&
      channel!.channelImageUrl!.isNotEmpty;

  bool get hasThumbnail =>
      channel != null &&
      channel!.thumbnailUrl != null &&
      channel!.thumbnailUrl!.isNotEmpty;
}
