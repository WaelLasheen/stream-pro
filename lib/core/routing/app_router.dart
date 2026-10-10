import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_pro/core/di/di.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/routing/path_not_found.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/feature/Likes/presentation/controllers/liked_videos_cubit/liked_videos_cubit.dart';
import 'package:stream_pro/feature/Likes/presentation/screens/liked_videos_screen.dart';
import 'package:stream_pro/feature/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/controller/splash_cubit/splash_cubit.dart';
import 'package:stream_pro/feature/auth/presentation/screen/login_screen.dart';
import 'package:stream_pro/feature/auth/presentation/screen/register_screen.dart';
import 'package:stream_pro/feature/auth/presentation/screen/splash_screen.dart';
import 'package:stream_pro/feature/category/presentation/controllers/category_cubit/category_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_details_cubit/channel_details_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_home_tab_cubit/channel_home_tab_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_playlists_cubit/channel_playlists_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/controllers/channel_videos_cubit/channel_videos_cubit.dart';
import 'package:stream_pro/feature/channel/presentation/screens/channel_screen.dart';
import 'package:stream_pro/feature/comments/presentation/controllers/comments_cubit/comments_cubit.dart';
import 'package:stream_pro/feature/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:stream_pro/feature/home/presentation/screen/home_screen.dart';
import 'package:stream_pro/feature/main/presentation/screen/main_shell_screen.dart';
import 'package:stream_pro/feature/notifications/presentation/controllers/notifications_cubit/notifications_cubit.dart';
import 'package:stream_pro/feature/notifications/presentation/screens/notifications_screen.dart';
import 'package:stream_pro/feature/owner_channel/presentation/args/channel_editor_args.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_channel_cubit/owner_channel_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_playlists_cubit/owner_playlists_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/owner_videos_cubit/owner_videos_cubit.dart';
import 'package:stream_pro/feature/owner_channel/presentation/screens/channel_editor_screen.dart';
import 'package:stream_pro/feature/owner_channel/presentation/screens/owner_channel_screen.dart';
import 'package:stream_pro/feature/search/presentation/controllers/search_cubit/search_cubit.dart';
import 'package:stream_pro/feature/search/presentation/screens/video_search_screen.dart';
import 'package:stream_pro/feature/owner_channel/presentation/controllers/subscribers_cubit/subscribers_cubit.dart';
import 'package:stream_pro/feature/subscriptions/presentation/controllers/subscriptions_cubit/subscriptions_cubit.dart';
import 'package:stream_pro/feature/subscriptions/presentation/screens/subscriptions_screen.dart';
import 'package:stream_pro/feature/video_details/presentation/controllers/video_details_cubit/video_details_cubit.dart';
import 'package:stream_pro/feature/video_details/presentation/screens/video_details_screen.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/edit_video_cubit/edit_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/controllers/upload_video_cubit/upload_video_cubit.dart';
import 'package:stream_pro/feature/video_management/presentation/screens/edit_video_screen.dart';
import 'package:stream_pro/feature/video_management/presentation/screens/upload_video_screen.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/video_track_cubit/video_track_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/controllers/watch_history_cubit/watch_history_cubit.dart';
import 'package:stream_pro/feature/watch_history/presentation/screens/watch_history_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<SplashCubit>()..start(),
            child: const SplashScreen(),
          ),
        );

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

      case AppRoutes.main:
        return MaterialPageRoute(builder: (context) => const MainShellScreen());

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>()..fetchFeed(),
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
              BlocProvider(
                create: (_) =>
                    getIt<CommentsCubit>()..fetchComments(videoId),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<VideoTrackCubit>()..startTracking(videoId: videoId),
              ),
            ],
            child: VideoDetailsScreen(videoId: videoId),
          ),
        );

      case AppRoutes.channelDetails:
        final channelId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    getIt<ChannelDetailsCubit>()
                      ..fetchChannelDetails(channelId),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<ChannelHomeTabCubit>()..fetchChannelHome(channelId),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<ChannelVideosCubit>()..fetchChannelVideos(channelId),
              ),
              BlocProvider(
                create: (_) =>
                    getIt<ChannelPlaylistsCubit>()
                      ..fetchChannelPlaylists(channelId),
              ),
            ],
            child: ChannelScreen(channelId: channelId),
          ),
        );

      case AppRoutes.ownerChannel:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<OwnerChannelCubit>()..fetchOwnerChannel(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<OwnerVideosCubit>()..fetchOwnerVideos(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<OwnerPlaylistsCubit>()..fetchOwnerPlaylists(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<SubscribersCubit>()..fetchSubscribers(),
              ),
            ],
            child: OwnerChannelScreen(),
          ),
        );

      case AppRoutes.channelEditor:
        final args = settings.arguments as ChannelEditorArgs;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: args.cubit,
            child: ChannelEditorScreen(
              initialData: args.channel,
              filePickerService: getIt<FilePickerService>(),
            ),
          ),
        );

      case AppRoutes.subscriptions:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<SubscriptionsCubit>()..fetchUserSubscriptions(),
            child: SubscriptionsScreen(),
          ),
        );

      case AppRoutes.uploadVideo:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<UploadVideoCubit>()),
              BlocProvider(
                create: (context) => getIt<CategoryCubit>()..fetchCategories(),
              ),
            ],
            child: UploadVideoScreen(
              filePickerService: getIt<FilePickerService>(),
            ),
          ),
        );

      case AppRoutes.editVideo:
        final String videoId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<EditVideoCubit>()..loadVideo(videoId: videoId),
              ),
              BlocProvider(
                create: (context) => getIt<CategoryCubit>()..fetchCategories(),
              ),
            ],
            child: EditVideoScreen(
              videoId: videoId,
              filePickerService: getIt<FilePickerService>(),
            ),
          ),
        );

      case AppRoutes.watchHistory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<WatchHistoryCubit>()..fetchWatchHistory(),
            child: const WatchHistoryScreen(),
          ),
        );

      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<NotificationsCubit>()..fetchNotifications(),
            child: const NotificationsScreen(),
          ),
        );

      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SearchCubit>()),
              BlocProvider(
                create: (context) => getIt<CategoryCubit>()..fetchCategories(),
              ),
            ],
            child: const VideoSearchScreen(),
          ),
        );

      case AppRoutes.likedVideo:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LikedVideosCubit>()..fetchLikedVideos(),
            child: const LikedVideosScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => const PathNotFound());
    }
  }
}
