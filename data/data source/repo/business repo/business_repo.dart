import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:dartz/dartz.dart';

abstract class BusinessRepo {
  Future<Either<Failure, void>> addBusiness(
      AddBusinessModel addBusinessModel, int baseCurrencyId, String imagePath);

  Future<Either<Failure, void>> editBusiness(
      AddBusinessModel editBusinessModel, String? imagePath);
  Future<Either<Failure, void>> getBusinessData();
  Future<Either<Failure, void>> deleteBusiness();
}
