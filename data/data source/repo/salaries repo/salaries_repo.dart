import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:almonazim/data/model/employees%20models/salary_model.dart';
import 'package:dartz/dartz.dart';

abstract class SalariesRepo {
  Future<Either<Failure, SalaryModel>> getOneEmployeeSalary(
      SalaryInputModel salaryInputModel);
  Future<Either<Failure, List<SalaryModel>>> getEmployeeSalaries(
      SalaryInputModel salaryInputModel);
  Future<Either<Failure, void>> editSalaryAmountById(
      SalaryInputModel salaryInputModel);

  Future<Either<Failure, void>> addSalary(SalaryInputModel salaryInputModel);
  Future<Either<Failure, void>> importSalaries(String filePath);
}
