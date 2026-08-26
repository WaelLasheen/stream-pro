import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/routing/path_not_found.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/screen/login_screen.dart';
import 'package:stream_pro/feature/auth/presentation/screen/register_screen.dart';
import 'package:stream_pro/feature/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:stream_pro/feature/home/presentation/screen/home_screen.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_comments_cubit/video_comments_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_likes_cubit/video_likes_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/screens/video_details_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );

      case AppRoutes.videoDetails:
        final videoId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    getIt<VideoDetailsCubit>()..loadVideoDetails(videoId),
              ),
              BlocProvider(create: (_) => getIt<VideoLikesCubit>()),
              BlocProvider(
                create: (_) =>
                    getIt<VideoCommentsCubit>()..fetchComments(videoId),
              ),
            ],
            child: VideoDetailsScreen(videoId: videoId),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => const PathNotFound());
    }
  }
}
