import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/playlist/data/datasources/playlist_remote_datasource.dart';
import 'package:stream_pro/feature/playlist/data/datasources/playlist_remote_datasource_impl.dart';
import 'package:stream_pro/feature/playlist/data/repositories/playlist_repository_impl.dart';
import 'package:stream_pro/feature/playlist/domain/repositories/playlist_repository.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/create_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/delete_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlist_details_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/get_playlists_for_video_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/reorder_playlist_videos_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/toggle_video_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/domain/use_cases/update_playlist_use_case.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_cubit.dart';
import '../di.dart';

void setUpPlaylist() {
  getIt.registerLazySingleton<PlaylistRemoteDataSource>(
    () => PlaylistRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<PlaylistRepository>(
    () => PlaylistRepositoryImpl(
      remoteDataSource: getIt<PlaylistRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetPlaylistsForVideoUseCase>(
    () => GetPlaylistsForVideoUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<GetPlaylistDetailsUseCase>(
    () => GetPlaylistDetailsUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<CreatePlaylistUseCase>(
    () => CreatePlaylistUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<UpdatePlaylistUseCase>(
    () => UpdatePlaylistUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<DeletePlaylistUseCase>(
    () => DeletePlaylistUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<ToggleVideoPlaylistUseCase>(
    () => ToggleVideoPlaylistUseCase(getIt<PlaylistRepository>()),
  );
  getIt.registerLazySingleton<ReorderPlaylistVideosUseCase>(
    () => ReorderPlaylistVideosUseCase(getIt<PlaylistRepository>()),
  );

  getIt.registerFactory<VideoPlaylistsCubit>(
    () => VideoPlaylistsCubit(
      getPlaylistsForVideoUseCase: getIt<GetPlaylistsForVideoUseCase>(),
      toggleVideoPlaylistUseCase: getIt<ToggleVideoPlaylistUseCase>(),
    ),
  );
  getIt.registerFactory<CreatePlaylistCubit>(
    () => CreatePlaylistCubit(
      createPlaylistUseCase: getIt<CreatePlaylistUseCase>(),
      toggleVideoPlaylistUseCase: getIt<ToggleVideoPlaylistUseCase>(),
    ),
  );
  getIt.registerFactory<PlaylistDetailsCubit>(
    () => PlaylistDetailsCubit(
      getPlaylistDetailsUseCase: getIt<GetPlaylistDetailsUseCase>(),
      updatePlaylistUseCase: getIt<UpdatePlaylistUseCase>(),
      deletePlaylistUseCase: getIt<DeletePlaylistUseCase>(),
      toggleVideoPlaylistUseCase: getIt<ToggleVideoPlaylistUseCase>(),
      reorderPlaylistVideosUseCase: getIt<ReorderPlaylistVideosUseCase>(),
    ),
  );
}
