import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/compensation%20repo/compensation_repo.dart';
import 'package:almonazim/data/model/employees%20models/all_compensation_model.dart';
import 'package:almonazim/data/model/employees%20models/compensation_input_model.dart';
import 'package:dartz/dartz.dart';

class CompensationRepoImpl implements CompensationRepo {
  final ApiService apiService;
  CompensationRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AllCompensationModel>> getEmployeesCompensation(
      CompensationInputModel compensationInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getEmployeeCompensationLink,
        formDataIsEnabled: false,
        data: compensationInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(AllCompensationModel.formJson(response["data"])),
    );
  }

  @override
  Future<Either<Failure, void>> deleteCompensation(
      CompensationInputModel compensationInputModel) async {
    final result = await apiService.post(
        url: AppLinks.deleteEmployeeCompensationLink,
        formDataIsEnabled: false,
        data: compensationInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> addCompensation(
      CompensationInputModel compensationInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addEmployeeCompensationLink,
        data: compensationInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
