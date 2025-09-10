import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_buildings_state.dart';

class ImportBuildingsCubit extends SafeCubit<ImportBuildingsState> {
  ImportBuildingsCubit(this.placeRepo) : super(ImportBuildingsInitial());
  PlaceRepo placeRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportBuildingsLoading());
      var response = await placeRepo.importBuildings(excelFile.path);
      response.fold((failure) {
        emit(ImportBuildingsFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportBuildingsSuccess());
      });
    } else {
      emit(const ImportBuildingsFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
