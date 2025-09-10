import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_employees_state.dart';

class ImportEmployeesCubit extends SafeCubit<ImportEmployeesState> {
  ImportEmployeesCubit(this.employeesRepo) : super(ImportEmployeesInitial());
  EmployeesRepo employeesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportEmployeesLoading());
      var response = await employeesRepo.importEmployees(excelFile.path);
      response.fold((failure) {
        emit(ImportEmployeesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportEmployeesSuccess());
      });
    } else {
      emit(const ImportEmployeesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
