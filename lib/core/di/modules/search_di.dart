import 'package:get_it/get_it.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/search/domain/use_cases/get_search_suggestions_use_case.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_suggestions_cubit/search_suggestions_cubit.dart';
import '../../../feature/search/data/datasources/search_remote_datasource.dart';
import '../../../feature/search/data/datasources/search_remote_datasource_impl.dart';
import '../../../feature/search/data/repositories/search_repository_impl.dart';
import '../../../feature/search/domain/repositories/search_repository.dart';
import '../../../feature/search/domain/use_cases/search_videos_use_case.dart';
import '../../../feature/search/presentation/controllers/search_cubit/search_cubit.dart';

void setUpSearch() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt<SearchRemoteDataSource>()),
  );
  getIt.registerLazySingleton<SearchVideosUseCase>(
    () => SearchVideosUseCase(getIt<SearchRepository>()),
  );

  getIt.registerLazySingleton(() => GetSearchSuggestionsUseCase(getIt()));

  getIt.registerFactory(
    () => SearchCubit(searchVideosUseCase: getIt<SearchVideosUseCase>()),
  );

  getIt.registerFactory(
    () => SearchSuggestionsCubit(getSearchSuggestionsUseCase: getIt()),
  );
}
