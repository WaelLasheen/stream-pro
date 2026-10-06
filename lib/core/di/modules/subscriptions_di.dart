import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/feature/subscriptions/data/datasources/subscriptions_remote_datasource.dart';
import 'package:stream_pro/feature/subscriptions/data/datasources/subscriptions_remote_datasource_impl.dart';
import 'package:stream_pro/feature/subscriptions/data/repositories/subscriptions_repository_impl.dart';
import 'package:stream_pro/feature/subscriptions/domain/repositories/subscriptions_repository.dart';
import 'package:stream_pro/feature/subscriptions/domain/use_cases/get_subscriptions_use_case.dart';
import 'package:stream_pro/feature/subscriptions/domain/use_cases/subscribe_to_channel_use_case.dart';
import 'package:stream_pro/feature/subscriptions/domain/use_cases/unsubscribe_to_channel_use_case.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/toggle_subscription_cubit/toggle_subscription_cubit.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/subscriptions_cubit/subscriptions_cubit.dart';
import '../di.dart';

void setUpSubscriptions() {
  getIt.registerLazySingleton<SubscriptionsRemoteDataSource>(
    () => SubscriptionsRemoteDataSourceImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SubscriptionsRepository>(
    () => SubscriptionsRepositoryImpl(
      remoteDataSource: getIt<SubscriptionsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => SubscribeToChannelUseCase(getIt<SubscriptionsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UnsubscribeToChannelUseCase(getIt<SubscriptionsRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetSubscriptionsUseCase(getIt<SubscriptionsRepository>()),
  );

  getIt.registerFactory(
    () => ToggleSubscriptionCubit(
      subscribeToChannelUseCase: getIt<SubscribeToChannelUseCase>(),
      unsubscribeFromChannelUseCase: getIt<UnsubscribeToChannelUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => SubscriptionsCubit(
      getSubscriptionsUseCase: getIt<GetSubscriptionsUseCase>(),
    ),
  );
}
