import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/vacations%20repo/vacations_repo.dart';
import 'package:almonazim/data/model/vacations%20models/add_vacation_model.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_input_model.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_model.dart';
import 'package:dartz/dartz.dart';

class VacationsRepoImpl implements VacationsRepo {
  final ApiService apiService;
  VacationsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> addVacation(
      AddVacationModel addVacationModel) async {
    final result = await apiService.post(
        url: AppLinks.addEmployeeVacationLink,
        formDataIsEnabled: false,
        data: addVacationModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> deleteVacation(
      VacationInputModel vacationInputModel) async {
    final result = await apiService.post(
        url: AppLinks.deleteEmployeeVacationLink,
        formDataIsEnabled: false,
        data: vacationInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, List<VacationModel>>> getEmployeeVacations(
      VacationInputModel vacationInputModel) async {
    vacationInputModel.vacationsTo ??= DateTime.now().toString();

    logger.w(vacationInputModel.toJson());
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.getEmployeesVacationsLink,
        data: vacationInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<VacationModel> vacations = [];
        for (final vacation in response["data"]) {
          vacations.add(VacationModel.fromJson(vacation));
        }
        return right(vacations);
      },
    );
  }
}
