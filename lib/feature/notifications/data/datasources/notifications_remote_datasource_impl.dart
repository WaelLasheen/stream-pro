import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/core/networking/api_service.dart';
import '../models/paginated_notifications_model.dart';
import 'notifications_remote_datasource.dart';

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiService _apiService;

  NotificationsRemoteDataSourceImpl(this._apiService);

  @override
  Future<PaginatedNotificationsModel> getNotifications({
    required int pageNumber,
    required int pageSize,
  }) async {
    final response = await _apiService.get(
      ApiConstants.notifications,
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    return PaginatedNotificationsModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    await _apiService.patch(ApiConstants.notifications);
  }

  @override
  Future<void> markNotificationAsRead(String id) async {
    await _apiService.patch(ApiConstants.notificationById(id));
  }

  @override
  Future<void> deleteAllNotifications() async {
    await _apiService.delete(ApiConstants.notifications);
  }

  @override
  Future<void> deleteNotification(String id) async {
    await _apiService.delete(ApiConstants.notificationById(id));
  }
}
