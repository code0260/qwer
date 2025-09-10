import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/assets%20repo/asset_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_assets_state.dart';

class ImportAssetsCubit extends SafeCubit<ImportAssetsState> {
  ImportAssetsCubit(this.assetRepo) : super(ImportAssetsInitial());
  AssetRepo assetRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportAssetsLoading());
      var response = await assetRepo.importAssets(excelFile.path);
      response.fold((failure) {
        emit(ImportAssetsFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportAssetsSuccess());
      });
    } else {
      emit(const ImportAssetsFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
