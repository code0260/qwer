import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/settings%20repo/settings_repo.dart';
import 'package:almonazim/data/model/settings%20models/settings_model.dart';
import 'package:dartz/dartz.dart';

class SettingsRepoImpl implements SettingsRepo {
  final ApiService apiService;
  SettingsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SettingsModel>> getSetting(String key) async {
    final result = await apiService.post(
        url: AppLinks.getSettingsLink,
        formDataIsEnabled: false,
        data: {'key': key});

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(SettingsModel.fromJson(response["data"][0]));
      },
    );
  }

  @override
  Future<Either<Failure, void>> addOrUpdateSetting(
      String key, String value) async {
    final result = await apiService.post(
        url: AppLinks.addOrUpdateSettingLink,
        formDataIsEnabled: false,
        data: {"key": key, "value": value});

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteSetting(String key) async {
    final result = await apiService
        .post(url: AppLinks.deleteSettingLink, data: {"key": key});

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
