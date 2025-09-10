import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_prices_state.dart';

class ImportPricesCubit extends SafeCubit<ImportPricesState> {
  ImportPricesCubit(this.pricesRepo) : super(ImportPricesInitial());
  PricesRepo pricesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportPricesLoading());
      var response = await pricesRepo.importPrices(excelFile.path);
      response.fold((failure) {
        emit(ImportPricesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportPricesSuccess());
      });
    } else {
      emit(const ImportPricesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
