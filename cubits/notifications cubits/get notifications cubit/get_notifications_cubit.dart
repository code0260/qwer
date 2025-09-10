import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/notifications%20repo/notification_repo_imp.dart';
import 'package:almonazim/data/model/notification%20models/notification_input_model.dart';
import 'package:almonazim/data/model/notification%20models/notifications_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends SafeCubit<GetNotificationsState> {
  GetNotificationsCubit(this.notificationRepo)
      : super(GetNotificationsInitial());
  NotificationRepoImpl notificationRepo;
  ScrollController controller = ScrollController();
  List<NotificationModel> allNotifications = [];
  NotificationInputModel notificationInputModel =
      NotificationInputModel(requestNumber: 0);

  Future<void> getNotifications() async {
    addingGridListener();
    emit(GetNotificationsLoading());
    var result =
        await notificationRepo.getNotifications(notificationInputModel);
    result.fold((failure) {
      emit(GetNotificationsFailure(failure.errMessage));
    }, (notificationsLocal) {
      allNotifications.addAll(notificationsLocal);
      emit(GetNotificationsSuccess(notifications: allNotifications));
    });
  }

  void refresh() async {
    notificationInputModel.requestNumber = 0;
    allNotifications.clear();
    getNotifications();
  }

  void addingGridListener() async {
    removingGridListener();
    await Future.delayed(const Duration(seconds: 1));
    controller.addListener(onGridScroll);
  }

  void removingGridListener() {
    // ignore: invalid_use_of_protected_member
    if (controller.hasListeners) {
      controller.removeListener(onGridScroll);
    } else {}
  }

  void disposeGridControl() {
    controller.dispose();
  }

  void onGridScroll() {
    if (controller.position.maxScrollExtent == controller.offset) {
      notificationInputModel.requestNumber =
          notificationInputModel.requestNumber! + 1;
      getNotifications();
    }
  }

  void setCategoryDataCompleted() {
    removingGridListener();
  }

  @override
  Future<void> close() {
    disposeGridControl();
    return super.close();
  }
}
