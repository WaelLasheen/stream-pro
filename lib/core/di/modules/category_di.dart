import 'package:get_it/get_it.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/category/data/datasources/category_remote_datasource.dart';
import 'package:stream_pro/feature/category/data/datasources/category_remote_datasource_impl.dart';
import 'package:stream_pro/feature/category/data/repositories/category_repository_impl.dart';
import 'package:stream_pro/feature/category/domain/repositories/category_repository.dart';
import 'package:stream_pro/feature/category/domain/use_cases/get_categories_use_case.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_cubit.dart';

void setUpCategory() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<CategoryRemoteDatasource>(
    () => CategoryRemoteDatasourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryRemoteDatasource>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoryRepository>()),
  );
  getIt.registerFactory(() => CategoryCubit(getIt<GetCategoriesUseCase>()));
}
