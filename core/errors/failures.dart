import 'package:almonazim/core/helper/functions/trial%20functions/show_trial_end_dialog.dart';
import 'package:almonazim/core/helper/functions/user%20functions/show_login_again_dialog.dart';
import 'package:almonazim/core/helper/functions/version%20functions/show_version_stopped_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('انتهت مهلة الاتصال بالخادم');
      case DioExceptionType.sendTimeout:
        return ServerFailure('انتهت مهلة إرسال البيانات إلى الخادم');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('انتهت مهلة استلام البيانات من الخادم');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('تم إلغاء الطلب إلى الخادم');
      case DioExceptionType.unknown:
        if ((dioError.error as dynamic).message!.contains('SocketException') ||
            (dioError.error as dynamic)
                .message!
                .contains('HandshakeException')) {
          return ServerFailure('لا يوجد اتصال بالإنترنت');
        }
        return ServerFailure('الرجاء التحقق من الانترنت والمحاولة مجدداً!');
      default:
        return ServerFailure('الرجاء التحقق من الانترنت والمحاولة مجدداً!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      var message = (response['message'] as String);
      var context = Get.context;
      if (context == null) {
        return ServerFailure(message);
      }

      if (message.contains('الوهمي')) {
        showTrialEndDialog(context);
      } else if (message.contains('تحديث التطبيق')) {
        showVersionStoppedDialog(context);
      } else if (message.contains('إعادة تسجيل الدخول')) {
        showLoginAgainDialog(context);
      }
      return ServerFailure(message);
    } else if (statusCode == 404) {
      return ServerFailure('الطلب غير موجود، يرجى المحاولة لاحقاً');
    } else if (statusCode == 500) {
      return ServerFailure('خطأ داخلي في الخادم، يرجى المحاولة لاحقاً');
    } else {
      return ServerFailure('عذرًا، حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure(super.errMessage);
}

class PrintFailure extends Failure {
  PrintFailure(super.errMessage);
}
