import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/general%20repo/general_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'add_done_import_state.dart';

class DoneImportDataCubit extends SafeCubit<DoneImportDataState> {
  DoneImportDataCubit(this.generalRepoImpl) : super(DoneImportDataInitial());
  GeneralRepoImpl generalRepoImpl;
  Future<void> doneImportData() async {
    emit(DoneImportDataLoading());
    var result = await generalRepoImpl.doneImportData();
    result.fold((failure) {
      emit(DoneImportDataFailure(failure.errMessage));
    }, (_) {
      emit(const DoneImportDataSuccess());
    });
  }

  String? get validateImportDataDataMessage {
    List<String> doneSteps = StoreInsertDateSteps.getDoneSteps() ?? [];
    if (doneSteps.isEmpty) {
      return "الرجاء إدخال البيانات";
    } else {
      return null;
    }
  }
}
