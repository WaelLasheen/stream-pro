import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/Likes/data/datasources/likes_remote_datasource.dart';
import 'package:stream_pro/feature/Likes/data/repositories/likes_repository_impl.dart';
import 'package:stream_pro/feature/Likes/domain/repositories/likes_repository.dart';
import 'package:stream_pro/feature/Likes/domain/use_cases/get_liked_videos_use_case.dart';
import 'package:stream_pro/feature/Likes/domain/use_cases/toggle_like_use_case.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_cubit.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/likes_cubit/likes_cubit.dart';

import '../di.dart';

void setUpLikes() {
  getIt.registerLazySingleton<LikesRemoteDataSource>(
    () => LikesRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<LikesRepository>(
    () => LikesRepositoryImpl(
      likesRemoteDataSource: getIt<LikesRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetLikedVideosUseCase>(
    () => GetLikedVideosUseCase(getIt<LikesRepository>()),
  );
  getIt.registerLazySingleton<ToggleLikeUseCase>(
    () => ToggleLikeUseCase(getIt<LikesRepository>()),
  );

  getIt.registerFactory(() => LikesCubit(getIt<ToggleLikeUseCase>()));
  getIt.registerFactory(() => LikedVideosCubit(getIt<GetLikedVideosUseCase>()));
}
