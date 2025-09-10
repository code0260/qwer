import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/store_almonazim_data.dart';
import 'package:almonazim/data/data%20source/locale/store_token.dart';
import 'package:almonazim/data/data%20source/locale/store_user.dart';
import 'package:almonazim/data/data%20source/repo/business%20repo/business_repo.dart';
import 'package:almonazim/data/model/almonazim_data_model.dart';
import 'package:almonazim/data/model/auth%20models/token_model.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';

class BusinessRepoImpl implements BusinessRepo {
  ApiService apiService;
  BusinessRepoImpl(this.apiService);
  @override
  Future<Either<Failure, void>> addBusiness(AddBusinessModel addBusinessModel,
      int baseCurrencyId, String? imagePath) async {
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
          url: AppLinks.addBusinessLink,
          data: data);
    } else {
      result = await apiService.post(
          url: AppLinks.addBusinessLink, formDataIsEnabled: true, data: data);
    }
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      //user
      StoreUser.setUser(StoreUserModel.fromJson(response["data"]));
      StoreAlmonazimData.setAlmonazimData(
          AlmonazimDataModel.fromJson(response["data"]));
      //token
      getIt.get<TokenModel>().fromJson(response["data"]);
      StoreToken.storeToken(getIt.get<TokenModel>());
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> editBusiness(
      AddBusinessModel editBusinessModel, String? imagePath) async {
    // print(addBusinessModel.toMap());
    var data = {
      "businessData": editBusinessModel.toMap(),
    };
    final Either<Failure, dynamic> result;
    if (imagePath != null) {
      result = await apiService.uploadFile(
          requestName: 'image',
          filePath: imagePath,
          url: AppLinks.editBusinessLink,
          data: data);
    } else {
      result = await apiService.post(
          url: AppLinks.editBusinessLink, formDataIsEnabled: true, data: data);
    }
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      var json = StoreUserModel.instance.toJson();
      json['business_image'] = response['data'];
      StoreUser.setUser(StoreUserModel.fromJson(json));
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> getBusinessData() async {
    // print(addBusinessModel.toMap());
    var result = await apiService.get(url: AppLinks.getBusinessLink);
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      //user
      StoreUser.setUser(StoreUserModel.fromJson(response["data"][0]));
      return right(null);
    });
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteBusiness() async {
    var result = await apiService.get(url: AppLinks.deleteBusinessLink);
    return result.fold((failure) {
      return left(failure);
    }, (response) {
      return right(null);
    });
    // return right(null);
  }
}
