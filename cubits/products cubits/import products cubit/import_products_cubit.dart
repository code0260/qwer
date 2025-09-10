import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20repo/product_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_products_state.dart';

class ImportProductsCubit extends SafeCubit<ImportProductsState> {
  ImportProductsCubit(this.productsRepo) : super(ImportProductsInitial());
  ProductsRepo productsRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportProductsLoading());
      var response = await productsRepo.importProducts(excelFile.path);
      response.fold((failure) {
        emit(ImportProductsFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportProductsSuccess());
      });
    } else {
      emit(const ImportProductsFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
