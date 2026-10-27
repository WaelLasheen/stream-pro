abstract class NotificationService {
  Future<void> initialize();
  Future<String?> getToken();
  Future<void> cancelAllNotifications();
  Stream<String> get onTokenRefresh;
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  void setOnNotificationTap(Function(Map<String, dynamic> data) callback);
}
