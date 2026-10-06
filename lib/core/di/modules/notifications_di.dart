import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:stream_pro/feature/notifications/data/datasources/notifications_remote_datasource_impl.dart';
import 'package:stream_pro/feature/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:stream_pro/feature/notifications/domain/repositories/notifications_repository.dart';
import 'package:stream_pro/feature/notifications/domain/use_cases/delete_notifications_use_cases.dart';
import 'package:stream_pro/feature/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:stream_pro/feature/notifications/domain/use_cases/mark_notifications_use_cases.dart';
import 'package:stream_pro/feature/notifications/presentation/controllers/notifications_cubit/notifications_cubit.dart';
import '../di.dart';

void setUpNotifications() {
  getIt.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(
      remoteDataSource: getIt<NotificationsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetNotificationsUseCase(getIt<NotificationsRepository>()),
  );
  getIt.registerLazySingleton(
    () => MarkAllNotificationsReadUseCase(getIt<NotificationsRepository>()),
  );
  getIt.registerLazySingleton(
    () => MarkNotificationReadUseCase(getIt<NotificationsRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteAllNotificationsUseCase(getIt<NotificationsRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteNotificationUseCase(getIt<NotificationsRepository>()),
  );

  getIt.registerFactory(
    () => NotificationsCubit(
      getNotificationsUseCase: getIt<GetNotificationsUseCase>(),
      markAllNotificationsReadUseCase: getIt<MarkAllNotificationsReadUseCase>(),
      markNotificationReadUseCase: getIt<MarkNotificationReadUseCase>(),
      deleteAllNotificationsUseCase: getIt<DeleteAllNotificationsUseCase>(),
      deleteNotificationUseCase: getIt<DeleteNotificationUseCase>(),
    ),
  );
}
