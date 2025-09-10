import 'package:almonazim/data/model/bought%20models/bought_info_input_model.dart';
import 'package:almonazim/data/model/bought%20models/bought_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class BoughtRepo {
  Future<Either<Failure, BoughtInfoModel>> getBoughtInfo(
      BoughtInfoInputModel boughtInfoInputModel);
}
