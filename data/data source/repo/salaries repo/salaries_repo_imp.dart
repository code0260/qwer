import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/salaries%20repo/salaries_repo.dart';
import 'package:almonazim/data/model/employees%20models/salary_input_model.dart';
import 'package:almonazim/data/model/employees%20models/salary_model.dart';
import 'package:dartz/dartz.dart';

class SalariesRepoImpl implements SalariesRepo {
  final ApiService apiService;
  SalariesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<SalaryModel>>> getEmployeeSalaries(
      SalaryInputModel salaryInputModel) async {
    salaryInputModel.endDate ??= DateTime.now();
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getEmployeeSalariesLink,
        data: salaryInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<SalaryModel> salaries = [];
        for (final salary in response["data"]) {
          salaries.add(SalaryModel.fromJson(salary));
        }
        return right(salaries);
      },
    );
  }

  @override
  Future<Either<Failure, SalaryModel>> getOneEmployeeSalary(
      SalaryInputModel salaryInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getOneEmployeeSalaryLink,
        data: salaryInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(SalaryModel.fromJson(response["data"]));
      },
    );
  }

  @override
  Future<Either<Failure, void>> editSalaryAmountById(
      SalaryInputModel salaryInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editSalaryAmountByIdLink,
        data: salaryInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addSalary(
      SalaryInputModel salaryInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addEmployeeSalaryLink,
        data: salaryInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importSalaries(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importSalariesLink,
        requestName: "salaries_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("13");
        return right(null);
      },
    );
  }
}
