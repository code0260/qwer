import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/salary%20slip%20functions/prepare_salary_slip_data.dart';
import 'package:almonazim/data/data%20source/repo/salary%20slips%20repo/salary_slips_repo.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_employee_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_input_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';
import 'package:dartz/dartz.dart';

class SalarySlipRepoImpl implements SalarySlipRepo {
  final ApiService apiService;
  SalarySlipRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<SalarySlipEmployeeModel>>>
      getUnpaidSalarySlips() async {
    final result = await apiService.get(
      url: AppLinks.getUnpaidSalarySlipsLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<SalarySlipEmployeeModel> salarySlipsEmployee = [];

        for (final salarySlipEmployee in response["data"]) {
          salarySlipsEmployee
              .add(SalarySlipEmployeeModel.fromMap(salarySlipEmployee));
        }
        return right(salarySlipsEmployee);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addSalarySlip(
      SalarySlipModel salarySlipModel) async {
    // print(prepareSalarySlipData(salarySlipModel));
    final result = await apiService.post(
        url: AppLinks.addOneSalarySlipLink,
        data: prepareSalarySlipData(salarySlipModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure('error'));
  }

  @override
  Future<Either<Failure, List<SalarySlipModel>>> getPaidSalarySlips(
      SalarySlipInputModel salarySlipInputModel) async {
    final requestData = salarySlipInputModel.toJson();

    final result = await apiService.post(
      formDataIsEnabled: false,
      url: AppLinks.getPaidSalarySlipsLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<SalarySlipModel> salarySlips = [];

        for (final salarySlip in response["data"]) {
          salarySlips.add(SalarySlipModel.fromJson(salarySlip));
        }
        return right(salarySlips);
      },
    );
  }
}
