import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/owner_channel/data/datasources/owner_channel_remote_datasource.dart';
import 'package:stream_pro/feature/owner_channel/data/datasources/owner_channel_remote_datasource_impl.dart';
import 'package:stream_pro/feature/owner_channel/data/repositories/owner_channel_repository_impl.dart';
import 'package:stream_pro/feature/owner_channel/domain/repositories/owner_channel_repository.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/create_owner_channel_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/get_owner_channel_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/get_owner_playlists_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/get_owner_videos_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/get_subscribers_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/update_channel_info_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/upload_channel_avatar_use_case.dart';
import 'package:stream_pro/feature/owner_channel/domain/use_cases/upload_channel_thumbnail_use_case.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_videos_cubit/owner_videos_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/subscribers_cubit/subscribers_cubit.dart';
import '../di.dart';

void setUpOwnerChannel() {
  getIt.registerLazySingleton<OwnerChannelRemoteDataSource>(
    () => OwnerChannelRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<OwnerChannelRepository>(
    () => OwnerChannelRepositoryImpl(
      remoteDataSource: getIt<OwnerChannelRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetOwnerChannelUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => CreateOwnerChannelUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateChannelInfoUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadChannelAvatarUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadChannelThumbnailUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetOwnerVideosUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetOwnerPlaylistsUseCase(getIt<OwnerChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetSubscribersUseCase(getIt<OwnerChannelRepository>()),
  );

  getIt.registerFactory(
    () => OwnerChannelCubit(
      getOwnerChannelUseCase: getIt<GetOwnerChannelUseCase>(),
      createOwnerChannelUseCase: getIt<CreateOwnerChannelUseCase>(),
      updateChannelInfoUseCase: getIt<UpdateChannelInfoUseCase>(),
      uploadChannelAvatarUseCase: getIt<UploadChannelAvatarUseCase>(),
      uploadChannelThumbnailUseCase: getIt<UploadChannelThumbnailUseCase>(),
    ),
  );
  getIt.registerFactory(
    () =>
        OwnerVideosCubit(getOwnerVideosUseCase: getIt<GetOwnerVideosUseCase>()),
  );
  getIt.registerFactory(
    () => OwnerPlaylistsCubit(
      getOwnerPlaylistsUseCase: getIt<GetOwnerPlaylistsUseCase>(),
    ),
  );
  getIt.registerFactory(
    () =>
        SubscribersCubit(getSubscribersUseCase: getIt<GetSubscribersUseCase>()),
  );
}
