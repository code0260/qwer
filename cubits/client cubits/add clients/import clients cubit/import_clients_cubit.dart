import 'dart:io';

import 'package:almonazim/core/helper/functions/other functions/pick_file.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/clients%20repo/client_repo.dart';
import 'package:equatable/equatable.dart';

part 'import_clients_state.dart';

class ImportClientsCubit extends SafeCubit<ImportClientsState> {
  ImportClientsCubit(this.clientsRepo) : super(ImportClientsInitial());
  ClientRepo clientsRepo;
  Future<void> uploadExcelFile() async {
    File? excelFile = await pickFile(allowedExtensions: ["xlsx", "XLSX"]);
    if (excelFile != null) {
      emit(ImportClientsLoading());
      var response = await clientsRepo.importClients(excelFile.path);
      response.fold((failure) {
        emit(ImportClientsFailure(errorMessage: failure.errMessage));
      }, (_) {
        emit(ImportClientsSuccess());
      });
    } else {
      emit(const ImportClientsFailure(errorMessage: "لم يتم اختيار ملف"));
    }
  }
}
