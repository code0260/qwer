import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/notifications%20repo/notification_repo.dart';
import 'package:almonazim/data/model/notification%20models/notification_input_model.dart';
import 'package:almonazim/data/model/notification%20models/notifications_model.dart';
import 'package:dartz/dartz.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;
  NotificationRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      NotificationInputModel notificationInputModel) async {
    final result = await apiService.post(
      url: AppLinks.getNotificationsLink,
      formDataIsEnabled: false,
      data: notificationInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<NotificationModel> notificationsLocale = [];
        for (final notification in response["data"]) {
          notificationsLocale.add(NotificationModel.fromJson(notification));
        }
        return right(notificationsLocale);
      },
    );
  }
}
