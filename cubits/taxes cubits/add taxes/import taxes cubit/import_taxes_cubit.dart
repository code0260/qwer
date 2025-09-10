import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/taxes%20repo/taxes_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_taxes_state.dart';

class ImportTaxesCubit extends SafeCubit<ImportTaxesState> {
  ImportTaxesCubit(this.taxesRepo) : super(ImportTaxesInitial());
  TaxesRepo taxesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportTaxesLoading());
      var response = await taxesRepo.importTaxes(excelFile.path);
      response.fold((failure) {
        emit(ImportTaxesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportTaxesSuccess());
      });
    } else {
      emit(const ImportTaxesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
