import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/revenues%20models/get_revenues_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_categories_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';
import 'package:dartz/dartz.dart';

abstract class RevenuesRepo {
  //$ get
  Future<Either<Failure, List<RevenuesCategoriesModel>>>
      getRevenuesCategories();
  Future<Either<Failure, GetRevenuesModel>> getRevenues(
      RevenueInputModel revenuesInputModel); //$ add
  Future<Either<Failure, void>> addRevenue(RevenueInputModel revenueInputModel);
  Future<Either<Failure, void>> addRentPrepaidRevenue(
      RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel);
  Future<Either<Failure, void>> importRentPrepaidRevenues(String filePath);
  Future<Either<Failure, void>> importRevenues(String filePath);
  //$ delete
  Future<Either<Failure, void>> deleteRevenue(
      RevenueInputModel revenuesInputModel);
  //$ edit
  Future<Either<Failure, void>> editRevenues(
      RevenueInputModel revenueInputModel, RevenuesModel revenuesModel);
}
