import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';
import '../../../domain/use_cases/create_owner_channel_use_case.dart';
import '../../../domain/use_cases/get_owner_channel_use_case.dart';
import '../../../domain/use_cases/update_channel_info_use_case.dart';
import '../../../domain/use_cases/upload_channel_avatar_use_case.dart';
import '../../../domain/use_cases/upload_channel_thumbnail_use_case.dart';
import 'owner_channel_state.dart';

class OwnerChannelCubit extends Cubit<OwnerChannelState> {
  final GetOwnerChannelUseCase getOwnerChannelUseCase;
  final CreateOwnerChannelUseCase createOwnerChannelUseCase;
  final UpdateChannelInfoUseCase updateChannelInfoUseCase;
  final UploadChannelAvatarUseCase uploadChannelAvatarUseCase;
  final UploadChannelThumbnailUseCase uploadChannelThumbnailUseCase;

  OwnerChannelCubit({
    required this.getOwnerChannelUseCase,
    required this.createOwnerChannelUseCase,
    required this.updateChannelInfoUseCase,
    required this.uploadChannelAvatarUseCase,
    required this.uploadChannelThumbnailUseCase,
  }) : super(const OwnerChannelInitialState());

  Future<void> fetchOwnerChannel() async {
    emit(const OwnerChannelLoadingState());
    final result = await getOwnerChannelUseCase();
    if (isClosed) return;

    result.fold((failure) {
      if (failure is ServerFailure && failure.statusCode == 404) {
        emit(const OwnerChannelNoChannelState());
      } else {
        emit(OwnerChannelErrorState(message: failure.message));
      }
    }, (channel) => emit(OwnerChannelLoadedState(channel)));
  }

  Future<void> createAndSetupChannel({
    required String title,
    String? description,
    String? avatarPath,
    String? thumbnailPath,
  }) async {
    emit(const OwnerChannelLoadingState());

    final createResult = await createOwnerChannelUseCase();
    if (isClosed) return;

    bool isCreated = false;
    createResult.fold(
      (failure) => emit(OwnerChannelErrorState(message: failure.message)),
      (_) => isCreated = true,
    );

    if (!isCreated) return;

    final List<Future> updateTasks = [];

    updateTasks.add(
      updateChannelInfoUseCase(title: title, description: description ?? ''),
    );

    if (avatarPath != null && avatarPath.isNotEmpty) {
      updateTasks.add(uploadChannelAvatarUseCase(avatarPath));
    }

    if (thumbnailPath != null && thumbnailPath.isNotEmpty) {
      updateTasks.add(uploadChannelThumbnailUseCase(thumbnailPath));
    }

    await Future.wait(updateTasks);

    await fetchOwnerChannel();
  }

  Future<void> updateChannelDetails({
    required String title,
    required String description,
    String? avatarPath,
    String? thumbnailPath,
  }) async {
    final currentChannel = state.channel;
    if (currentChannel == null) return;

    emit(OwnerChannelLoadingState());

    final List<Future> updateTasks = [];
    String? newThumbnail;
    String? newAvatar;

    if (title != currentChannel.title ||
        description != currentChannel.description) {
      updateTasks.add(
        updateChannelInfoUseCase(title: title, description: description),
      );
    }

    if (avatarPath != null && avatarPath.isNotEmpty) {
      updateTasks.add(() async {
        final result = await uploadChannelAvatarUseCase(avatarPath);
        result.fold((_) {}, (url) => newAvatar = url);
      }());
    }

    if (thumbnailPath != null && thumbnailPath.isNotEmpty) {
      updateTasks.add(() async {
        final result = await uploadChannelThumbnailUseCase(thumbnailPath);
        result.fold((_) {}, (url) => newThumbnail = url);
      }());
    }

    await Future.wait(updateTasks);
    if (isClosed) return;

    emit(
      OwnerChannelLoadedState(
        currentChannel.copyWith(
          title: title,
          description: description,
          channelImageUrl: newAvatar,
          thumbnailUrl: newThumbnail,
        ),
      ),
    );
  }
}
