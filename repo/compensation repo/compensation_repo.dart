import 'package:almonazim/data/model/employees%20models/all_compensation_model.dart';
import 'package:almonazim/data/model/employees%20models/compensation_input_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class CompensationRepo {
  //$ get
  Future<Either<Failure, AllCompensationModel>> getEmployeesCompensation(
      CompensationInputModel
          compensationInputModel); // Future<Either<Failure, void>> editSalaryAmountById(
  //     SalaryInputModel salaryInputModel);
  //$ delete
  Future<Either<Failure, void>> deleteCompensation(
      CompensationInputModel compensationInputModel);
  //$ add
  Future<Either<Failure, void>> addCompensation(
      CompensationInputModel compensationInputModel);
}
