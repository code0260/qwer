import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'import_product_places_state.dart';

class ImportProductPlacesCubit extends SafeCubit<ImportProductPlacesState> {
  ImportProductPlacesCubit(this.productPlaceRepoImpl)
      : super(ImportProductPlacesInitial());
  ProductPlaceRepoImpl productPlaceRepoImpl;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportProductPlacesLoading());
      var response =
          await productPlaceRepoImpl.importProductPlaces(excelFile.path);
      response.fold((failure) {
        emit(ImportProductPlacesFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportProductPlacesSuccess());
      });
    } else {
      emit(const ImportProductPlacesFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
