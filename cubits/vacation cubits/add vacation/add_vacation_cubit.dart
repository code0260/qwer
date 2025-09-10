import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/vacations%20repo/vacations_repo_imp.dart';
import 'package:almonazim/data/model/vacations%20models/add_vacation_model.dart';
import 'package:equatable/equatable.dart';

part 'add_vacation_state.dart';

class AddVacationCubit extends SafeCubit<AddVacationState> {
  AddVacationCubit(this.vacationRepoImpl) : super(AddVacationInitial());
  VacationsRepoImpl vacationRepoImpl;
  AddVacationModel addVacationModel =
      AddVacationModel(vacationsWorkDate: DateTime.now().toString());

  Future<void> addVacation() async {
    emit(AddVacationLoading());
    var result = await vacationRepoImpl.addVacation(addVacationModel);
    result.fold((failure) {
      emit(AddVacationFailure(failure.errMessage));
    }, (_) {
      emit(AddVacationSuccess());
    });
  }

  String? get validateDataMessage {
    if (addVacationModel.vacationsType == null) {
      return "الرجاء اختيار المدة";
    } else if (addVacationModel.vacationsFrom == null) {
      return "الرجاء اختيار بداية الإجازة";
    } else if (addVacationModel.vacationsTo == null) {
      return "الرجاء اختيار نهاية الإجازة";
    } else if (addVacationModel.vacationsReason == "") {
      return "الرجاء إدخال السبب";
    } else if (addVacationModel.vacationsEmployeesId == null) {
      return "الرجاء اختيار الموظف";
    } else if (addVacationModel.vacationsType == "weekly") {
      String? value = checkWeeklyTrue();
      if (value != null) {
        return value;
      }
    } else if (addVacationModel.vacationsType == "monthly") {
      String? value = checkMonthlyTrue();
      if (value != null) {
        return value;
      }
    } else {
      return null;
    }
    return null;
  }

  int get differenceInDays {
    return DateTime.parse(addVacationModel.vacationsTo!)
        .difference(DateTime.parse(addVacationModel.vacationsFrom!))
        .inDays;
  }

  String? checkMonthlyTrue() {
    double months = differenceInDays / 30;
    int integerPart = "$months".substring(0, 1).toInt();
    double decimalPart = ("0${"$months".substring(1)}").toDouble();
    if (integerPart == 0) {
      if (decimalPart > 0.70) {
        // its oky
      } else {
        return "الرجاء اختيار نوعية الإجازة وعدد الأيام بشكل صحيح";
      }
    } else {
      if (decimalPart < 0.30 || decimalPart > 0.70) {
        // it is oky
      } else {
        return "الرجاء اختيار نوعية الإجازة وعدد الأيام بشكل صحيح";
      }
    }
    return null;
  }

  String? checkWeeklyTrue() {
    double months = differenceInDays / 7;
    int integerPart = "$months".substring(0, 1).toInt();
    double decimalPart = ("0${"$months".substring(1)}").toDouble();
    if (integerPart == 0) {
      if (decimalPart > 0.70) {
        // its oky
      } else {
        return "الرجاء اختيار نوعية الإجازة وعدد الأيام بشكل صحيح";
      }
    } else {
      if (decimalPart < 0.30 || decimalPart > 0.70) {
        // it is oky
      } else {
        return "الرجاء اختيار نوعية الإجازة وعدد الأيام بشكل صحيح";
      }
    }
    return null;
  }
}
