import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class SellsRepo {
  Future<Either<Failure, SellsInfoModel>> getSellsInfo(
      SellsInfoInputModel sellsInfoInputModel);
}
