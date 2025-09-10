import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/store_token.dart';
import 'package:almonazim/data/data%20source/locale/store_user.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo.dart';
import 'package:almonazim/data/model/auth%20models/token_model.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:almonazim/data/model/user%20models/user_model.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl implements UserRepo {
  ApiService apiService;
  UserRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> enterDemoAccount(
      UserInputModel userInputModel) async {
    // print(addBusinessModel.toMap());
    var result = await apiService.post(
        url: AppLinks.enterDemoAccountLink,
        formDataIsEnabled: false,
        data: userInputModel.toMap());
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> finishDemoAccount(
      AddBusinessModel addBusinessModel,
      int baseCurrencyId,
      String? imagePath) async {
    // print(addBusinessModel.toMap());
    var data = {
      "businessData": addBusinessModel.toMap(),
      "base_currency_id": baseCurrencyId
    };
    final Either<Failure, dynamic> result;
    if (imagePath != null) {
      result = await apiService.uploadFile(
          requestName: 'image',
          filePath: imagePath,
          url: AppLinks.finishDemoAccountLink,
          data: data);
    } else {
      result = await apiService.post(
          url: AppLinks.finishDemoAccountLink,
          formDataIsEnabled: true,
          data: data);
    }
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      //user
      StoreUser.setUser(StoreUserModel.fromJson(response["data"]));
      //token
      getIt.get<TokenModel>().fromJson(response["data"]);
      StoreToken.storeToken(getIt.get<TokenModel>());
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    final result = await apiService.get(url: AppLinks.getUsersLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<UserModel> usersLocale = [];
        for (final user in response["data"]) {
          usersLocale.add(UserModel.fromJson(user));
        }
        return right(usersLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editUser(UserInputModel userInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        data: userInputModel.toMap(),
        url: AppLinks.editUserLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addUser(UserInputModel userInputModel) async {
    // print(addBusinessModel.toMap());
    var result = await apiService.post(
        url: AppLinks.addUserLink,
        formDataIsEnabled: false,
        data: userInputModel.toMap());
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final result = await apiService.get(
      url: AppLinks.logoutLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
