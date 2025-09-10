import 'package:dartz/dartz.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/unit_model.dart';

abstract class UnitRepo {
  Future<Either<Failure, String>> deleteUnit(UnitModel unitModel);
  Future<Either<Failure, void>> addUnit(UnitModel unitModel);
  Future<Either<Failure, String>> editUnit(UnitModel unitModel);
  Future<Either<Failure, void>> getAllUnits();
  Future<Either<Failure, List<UnitModel>>> getUnitsByGroup(UnitGroup unitGroup);
  Future<Either<Failure, List<UnitModel>>> refreshUnits(UnitGroup unitGroup);
  UnitModel completeUnitModel(UnitModel unitModel);
  UnitModel getBiggestUnitBySmallId(int unitsId);
  Future<Either<Failure, Map>> addMultipleUnits(List<UnitModel> units);
}
