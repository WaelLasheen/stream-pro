import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/app_config/app_config_state.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/live_error_logger/crashlytics_service.dart';
import 'package:stream_pro/core/routing/app_router.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/theme/app_themes.dart';
import 'package:stream_pro/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocators();
  FlutterError.onError = (FlutterErrorDetails details) {
    getIt<CrashlyticsService>().logFatal(
      details.exception,
      details.stack ?? StackTrace.current,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<CrashlyticsService>().logFatal(error, stack);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return BlocProvider(
          create: (_) => getIt<AppConfigCubit>(),
          child: BlocBuilder<AppConfigCubit, AppConfigState>(
            builder: (_, configState) {
              return MaterialApp(
                title: 'StreamPro',
                debugShowCheckedModeBanner: false,

                // Theme Configuration
                theme: AppThemes().lightTheme,
                themeMode: configState.themeMode,

                // Localization Configuration
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: configState.locale,

                // Navigation & Routing
                navigatorKey: navigatorKey,
                onGenerateRoute: getIt<AppRouter>().onGenerateRoute,
                initialRoute: AppRoutes.login,
              );
            },
          ),
        );
      },
    );
  }
}
