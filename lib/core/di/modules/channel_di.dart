import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/channel/data/datasources/channel_remote_datasource.dart';
import 'package:stream_pro/feature/channel/data/datasources/channel_remote_datasource_impl.dart';
import 'package:stream_pro/feature/channel/data/repositories/channel_repository_impl.dart';
import 'package:stream_pro/feature/channel/domain/repositories/channel_repository.dart';
import 'package:stream_pro/feature/channel/domain/use_cases/get_channel_details_use_case.dart';
import 'package:stream_pro/feature/channel/domain/use_cases/get_channel_home_use_case.dart';
import 'package:stream_pro/feature/channel/domain/use_cases/get_channel_playlists_use_case.dart';
import 'package:stream_pro/feature/channel/domain/use_cases/get_channel_videos_use_case.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_home_tab_cubit/channel_home_tab_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_playlists_cubit/channel_playlists_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_videos_cubit/channel_videos_cubit.dart';
import '../di.dart';

void setUpChannel() {
  getIt.registerLazySingleton<ChannelRemoteDataSource>(
    () => ChannelRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ChannelRepository>(
    () => ChannelRepositoryImpl(
      remoteDataSource: getIt<ChannelRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetChannelDetailsUseCase(getIt<ChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetChannelHomeUseCase(getIt<ChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetChannelVideosUseCase(getIt<ChannelRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetChannelPlaylistsUseCase(getIt<ChannelRepository>()),
  );

  getIt.registerFactory(
    () => ChannelDetailsCubit(
      getChannelDetailsUseCase: getIt<GetChannelDetailsUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ChannelHomeTabCubit(
      getChannelHomeUseCase: getIt<GetChannelHomeUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ChannelVideosCubit(
      getChannelVideosUseCase: getIt<GetChannelVideosUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ChannelPlaylistsCubit(
      getChannelPlaylistsUseCase: getIt<GetChannelPlaylistsUseCase>(),
    ),
  );
}
