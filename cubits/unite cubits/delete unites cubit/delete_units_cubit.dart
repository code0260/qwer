import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_units_state.dart';

class DeleteUnitCubit extends SafeCubit<DeleteUnitState> {
  DeleteUnitCubit(this.unitRepo) : super(DeleteUnitInitial());
  UnitRepoImpl unitRepo;
  Future<void> deleteUnit(UnitModel unitModel) async {
    emit(DeleteUnitLoading());
    var result = await unitRepo.deleteUnit(unitModel);
    result.fold((failure) {
      emit(DeleteUnitFailure(failure.errMessage));
    }, (units) {
      emit(DeleteUnitSuccess());
    });
  }
}
