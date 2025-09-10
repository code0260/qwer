// lib/data/data source/repo/auth repo/auth_repo_imp.dart

import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/store_almonazim_data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/locale/store_token.dart';
import 'package:almonazim/data/data%20source/locale/store_user.dart';
import 'package:almonazim/data/data%20source/repo/auth%20repo/auth_repo.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';
import 'package:almonazim/data/model/auth%20models/login_request_model.dart';
import 'package:almonazim/data/model/auth%20models/token_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> login(LoginRequestModel loginRequest) async {
    var result = await apiService.post(
      url: AppLinks.login,
      data: loginRequest.toJson(),
    );

    return result.fold(
          (failure) {
        return left(failure);
      },
          (response) async {
        // user
        await StoreUser.setUser(
            StoreUserModel.fromJson(response['data']["user_data"]));
        await StoreAlmonazimData.setAlmonazimData(
            AlmonazimDataModel.fromJson(response["data"]['almonazim_data']));

        //token
        getIt.get<TokenModel>().fromJson(response['data']["user_data"]);
        StoreToken.storeToken(getIt.get<TokenModel>());

        // steps
        if (response['data']['steps'] != null &&
            response['data']['steps'].isNotEmpty) {
          for (final step in response['data']['steps'] as List<dynamic>) {
            await StoreInsertDateSteps.addStep(step.toString());
          }
        }
        return right(null);
      },
    );
  }

  // ==== الدالة الجديدة لجلب بيانات المستخدم ==== //
  @override
  Future<Either<Failure, StoreUserModel>> getProfile() async {
    // استخدمنا .get لأن الطلب من نوع GET
    var result = await apiService.get(url: AppLinks.profile);

    return result.fold(
          (failure) {
        // في حال حدوث خطأ، قم بإرجاعه
        return left(failure);
      },
          (response) async {
        // في حال النجاح، قم بتحويل الـ JSON إلى موديل
        final userModel = StoreUserModel.fromJson(response);

        // قم بتحديث بيانات المستخدم المخزنة محلياً
        await StoreUser.setUser(userModel);

        // قم بإرجاع الموديل للجهة التي استدعت الدالة (مثلاً الـ Cubit)
        return right(userModel);
      },
    );
  }
}