import 'package:almonazim/data/model/vacations%20models/add_vacation_model.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_input_model.dart';
import 'package:almonazim/data/model/vacations%20models/vacation_model.dart';
import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';

abstract class VacationsRepo {
  //$ get
  Future<Either<Failure, List<VacationModel>>> getEmployeeVacations(
      VacationInputModel vacationInputModel);
  //$ add
  Future<Either<Failure, void>> addVacation(AddVacationModel addVacationModel);
  //$ delete
  Future<Either<Failure, void>> deleteVacation(
      VacationInputModel vacationInputModel);
}
