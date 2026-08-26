import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stream_pro/core/notifications/notification_service.dart';
import 'package:stream_pro/core/utils/helper/app_debugging_print.dart';
import 'package:stream_pro/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppDebuggingPrint.printDebug('📩 Background message: ${message.messageId}');
}

class NotificationServiceImpl implements NotificationService {
  final FirebaseMessaging _fcm;
  final FlutterLocalNotificationsPlugin _localNotifications;

  NotificationServiceImpl({
    FirebaseMessaging? fcm,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _fcm = fcm ?? FirebaseMessaging.instance,
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  Function(Map<String, dynamic>)? _onNotificationTap;
  Map<String, dynamic>? _pendingInitialPayload;

  @override
  Future<void> initialize() async {
    // 1. Background handler
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 2. Request permissions
    await _requestPermissions();

    // 3. Init local notifications (للـ foreground)
    await _initLocalNotifications();

    // 4. Get token
    await _getToken();

    // 5. Listen for token refresh
    _fcm.onTokenRefresh.listen(_handleTokenRefresh);

    // 6. Foreground messages → show local notification
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 7. Background tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 8. Terminated state (app opened from notification)
    await _checkInitialMessage();

    AppDebuggingPrint.printDebug(
      '✅ NotificationService initialized successfully',
    );
  }

  Future<void> _requestPermissions() async {
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    AppDebuggingPrint.printDebug(
      '🔔 Permission Status: ${settings.authorizationStatus}',
    );
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create Android notification channel
    if (Platform.isAndroid) {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  Future<String?> _getToken() async {
    try {
      if (Platform.isIOS) {
        String? apnsToken;
        int retryCount = 0;
        while (apnsToken == null && retryCount < 5) {
          apnsToken = await _fcm.getAPNSToken();
          if (apnsToken == null) {
            await Future.delayed(const Duration(seconds: 1));
            retryCount++;
          }
        }
      }
      _fcmToken = await _fcm.getToken();
      AppDebuggingPrint.printDebug('🔑 FCM Token: $_fcmToken');
      return _fcmToken;
    } catch (e) {
      AppDebuggingPrint.printDebug('❌ Error getting FCM token: $e');
      return null;
    }
  }

  void _handleTokenRefresh(String newToken) {
    AppDebuggingPrint.printDebug('🔄 Token refreshed: $newToken');
    _fcmToken = newToken;
    // TODO: Send new token to backend API when ready
  }

  void _handleForegroundMessage(RemoteMessage message) {
    AppDebuggingPrint.printDebug(
      '📩 Foreground message received: ${message.notification?.title}',
    );
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null) {
      final notificationId =
          (message.messageId ??
                  DateTime.now().millisecondsSinceEpoch.toString())
              .hashCode
              .abs() %
          2147483647;

      final payloadData = _extractPayloadData(message);

      _localNotifications.show(
        id: notificationId,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(payloadData),
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    AppDebuggingPrint.printDebug('👆 Background tap: ${message.data}');
    _triggerTapCallback(_extractPayloadData(message));
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        _triggerTapCallback(data);
      } catch (e) {
        AppDebuggingPrint.printDebug(
          '❌ Error parsing local notification payload: $e',
        );
      }
    }
  }

  Future<void> _checkInitialMessage() async {
    final message = await _fcm.getInitialMessage();
    if (message != null) {
      _triggerTapCallback(_extractPayloadData(message));
    }
  }

  Map<String, dynamic> _extractPayloadData(RemoteMessage message) {
    final data = Map<String, dynamic>.from(message.data);
    if (message.notification != null) {
      data.putIfAbsent('title', () => message.notification!.title);
      data.putIfAbsent('body', () => message.notification!.body);
    }
    return data;
  }

  void _triggerTapCallback(Map<String, dynamic> data) {
    if (_onNotificationTap != null) {
      _onNotificationTap!.call(data);
    } else {
      _pendingInitialPayload = data;
    }
  }

  @override
  Future<String?> getToken() async => _fcmToken;

  @override
  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  @override
  Future<void> subscribeToTopic(String topic) => _fcm.subscribeToTopic(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) =>
      _fcm.unsubscribeFromTopic(topic);

  @override
  void setOnNotificationTap(Function(Map<String, dynamic> data) callback) {
    _onNotificationTap = callback;
    if (_pendingInitialPayload != null) {
      _onNotificationTap!.call(_pendingInitialPayload!);
      _pendingInitialPayload = null;
    }
  }
}
