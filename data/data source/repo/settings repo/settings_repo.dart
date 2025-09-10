import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/settings%20models/settings_model.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepo {
  Future<Either<Failure, SettingsModel>> getSetting(String key);
  Future<Either<Failure, void>> addOrUpdateSetting(String key, String value);
  Future<Either<Failure, void>> deleteSetting(String key);
}
