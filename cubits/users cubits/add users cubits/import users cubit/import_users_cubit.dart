import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_users_state.dart';

class ImportUsersCubit extends SafeCubit<ImportUsersState> {
  ImportUsersCubit(this.partnerRepo) : super(ImportUsersInitial());
  PartnerRepo partnerRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportUsersLoading());
      var response = await partnerRepo.importUsers(excelFile.path);
      response.fold((failure) {
        emit(ImportUsersFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportUsersSuccess());
      });
    } else {
      emit(const ImportUsersFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
