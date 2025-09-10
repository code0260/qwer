import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_employee_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_input_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class SalarySlipRepo {
  Future<Either<Failure, List<SalarySlipEmployeeModel>>> getUnpaidSalarySlips();

  Future<Either<Failure, void>> addSalarySlip(SalarySlipModel salarySlipModel);

  Future<Either<Failure, List<SalarySlipModel>>> getPaidSalarySlips(
      SalarySlipInputModel salarySlipInputModel);
}
