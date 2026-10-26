import 'package:get_it/get_it.dart';
import 'package:stream_pro/core/di/modules/category_di.dart';
import 'package:stream_pro/core/di/modules/comments_di.dart';
import 'package:stream_pro/core/di/modules/likes_di.dart';
import 'package:stream_pro/core/di/modules/notifications_di.dart';
import 'package:stream_pro/core/di/modules/owner_channel_di.dart';
import 'package:stream_pro/core/di/modules/playlist_di.dart';
import 'package:stream_pro/core/di/modules/search_di.dart';
import 'modules/auth_di.dart';
import 'modules/channel_di.dart';
import 'modules/core_di.dart';
import 'modules/home_di.dart';
import 'modules/profile_di.dart';
import 'modules/subscriptions_di.dart';
import 'modules/video_details_di.dart';
import 'modules/video_management_di.dart';
import 'modules/watch_history_di.dart';

final getIt = GetIt.instance;
Future<void> setUpLocators() async {
  setUpBlocObserver();
  await Future.wait([setUpStorage(), firebaseInitializeApp()]);
  await Future.wait([
    setUpApiService(),
    setupErrorLoggerService(),
    setUpNotificationService(),
  ]);
  setUpConfig();
  setUpFilePicker();
  setUpRouter();
  setUpAuth();
  setUpHome();
  setUpVideoDetails();
  setUpChannel();
  setUpOwnerChannel();
  setUpSubscriptions();
  setUpVideoManagement();
  setUpWatchHistory();
  setUpNotifications();
  setUpSearch();
  setUpCategory();
  setUpLikes();
  setUpComments();
  setUpProfile();
  setUpPlaylist();
}
