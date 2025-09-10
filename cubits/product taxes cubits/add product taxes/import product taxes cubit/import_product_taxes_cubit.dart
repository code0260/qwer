import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20taxes%20repo/product_taxes_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_product_taxes_state.dart';

class ImportProductTaxesCubit extends SafeCubit<ImportProductTaxesState> {
  ImportProductTaxesCubit(this.taxesRepo) : super(ImportProductTaxesInitial());
  ProductTaxesRepo taxesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportProductTaxesLoading());
      var response = await taxesRepo.importProductTaxes(excelFile.path);
      response.fold((failure) {
        emit(ImportProductTaxesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportProductTaxesSuccess());
      });
    } else {
      emit(const ImportProductTaxesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
