import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/categories%20repo/categories_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_categories_state.dart';

class ImportCategoriesCubit extends SafeCubit<ImportCategoriesState> {
  ImportCategoriesCubit(this.categoriesRepo) : super(ImportCategoriesInitial());
  CategoriesRepo categoriesRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportCategoriesLoading());
      var response = await categoriesRepo.importCategories(excelFile.path);
      response.fold((failure) {
        emit(ImportCategoriesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportCategoriesSuccess());
      });
    } else {
      emit(const ImportCategoriesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
