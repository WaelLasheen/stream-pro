import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/video_details/data/datasources/comments_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/datasources/video_remote_datasource.dart';
import 'package:stream_pro/feature/video_details/data/repositories/video_details_repository_impl.dart';
import 'package:stream_pro/feature/video_details/domain/repositories/video_details_repository.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/add_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/delete_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_comments_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/get_video_details_use_case.dart';
import 'package:stream_pro/feature/video_details/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import '../di.dart';

void setUpVideoDetails() {
  getIt.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<VideoDetailsRepository>(
    () => VideoDetailsRepositoryImpl(
      videoRemoteDataSource: getIt<VideoRemoteDataSource>(),
      commentsRemoteDataSource: getIt<CommentsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetVideoDetailsUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetCommentsUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddCommentUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateCommentUseCase(getIt<VideoDetailsRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCommentUseCase(getIt<VideoDetailsRepository>()),
  );

  getIt.registerFactory(
    () => VideoDetailsCubit(getIt<GetVideoDetailsUseCase>()),
  );
  getIt.registerFactory(
    () => VideoCommentsCubit(
      getCommentsUseCase: getIt<GetCommentsUseCase>(),
      addCommentUseCase: getIt<AddCommentUseCase>(),
      updateCommentUseCase: getIt<UpdateCommentUseCase>(),
      deleteCommentUseCase: getIt<DeleteCommentUseCase>(),
    ),
  );
}
