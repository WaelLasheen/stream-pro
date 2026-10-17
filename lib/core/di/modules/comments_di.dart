import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/comments/data/datasources/comments_remote_datasource.dart';
import 'package:stream_pro/feature/comments/data/datasources/comments_remote_datasource_impl.dart';
import 'package:stream_pro/feature/comments/data/repositories/comments_repository_impl.dart';
import 'package:stream_pro/feature/comments/domain/repositories/comments_repository.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/add_comment_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/delete_comment_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/get_comments_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/get_replies_use_case.dart';
import 'package:stream_pro/feature/comments/domain/use_cases/update_comment_use_case.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/replies_cubit/replies_cubit.dart';

void setUpComments() {
  getIt.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(
      remoteDataSource: getIt<CommentsRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetCommentsUseCase(getIt<CommentsRepository>()),
  );
  getIt.registerLazySingleton(
    () => AddCommentUseCase(getIt<CommentsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateCommentUseCase(getIt<CommentsRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteCommentUseCase(getIt<CommentsRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetRepliesUseCase(getIt<CommentsRepository>()),
  );

  getIt.registerFactory(
    () => CommentsCubit(
      getCommentsUseCase: getIt<GetCommentsUseCase>(),
      addCommentUseCase: getIt<AddCommentUseCase>(),
      updateCommentUseCase: getIt<UpdateCommentUseCase>(),
      deleteCommentUseCase: getIt<DeleteCommentUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => RepliesCubit(
      getRepliesUseCase: getIt<GetRepliesUseCase>(),
      addCommentUseCase: getIt<AddCommentUseCase>(),
      updateCommentUseCase: getIt<UpdateCommentUseCase>(),
      deleteCommentUseCase: getIt<DeleteCommentUseCase>(),
    ),
  );
}
