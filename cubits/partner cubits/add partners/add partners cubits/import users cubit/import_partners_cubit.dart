import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_partners_state.dart';

class ImportPartnersCubit extends SafeCubit<ImportPartnersState> {
  ImportPartnersCubit(this.partnerRepo) : super(ImportPartnersInitial());
  PartnerRepo partnerRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportPartnersLoading());
      var response = await partnerRepo.importPartners(excelFile.path);
      response.fold((failure) {
        emit(ImportPartnersFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportPartnersSuccess());
      });
    } else {
      emit(const ImportPartnersFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
