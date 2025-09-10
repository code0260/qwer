import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/notification%20models/notification_input_model.dart';
import 'package:almonazim/data/model/notification%20models/notifications_model.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
      NotificationInputModel notificationInputModel);
}
