import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:equatable/equatable.dart';

part 'get_units_state.dart';

class GetUnitCubit extends SafeCubit<GetUnitState> {
  GetUnitCubit(this.unitRepo) : super(GetUnitInitial());
  UnitRepoImpl unitRepo;
  Future<void> getUnitByGroup(UnitGroup unitGroup) async {
    emit(GetUnitLoading());
    var result = await unitRepo.getUnitsByGroup(unitGroup);
    result.fold((failure) {
      emit(GetUnitFailure(failure.errMessage));
    }, (units) {
      emit(GetUnitSuccess(units: units));
    });
  }

  Future<void> refreshUnits(UnitGroup unitGroup) async {
    emit(GetUnitLoading());
    var result = await unitRepo.refreshUnits(unitGroup);
    result.fold((failure) {
      emit(GetUnitFailure(failure.errMessage));
    }, (units) {
      emit(GetUnitSuccess(units: units));
    });
  }

  Future<void> refreshAllUnitsOnline() async {
    emit(GetUnitLoading());
    var result = await unitRepo.getAllUnits();
    result.fold((failure) {
      emit(GetUnitFailure(failure.errMessage));
    }, (units) {
      emit(GetUnitSuccess(units: units));
    });
  }

  Future<void> refreshAllUnits() async {
    if (StoreWorkOffline.getWorkOffline() == true) {
      getAllUnits();
    } else {
      refreshAllUnitsOnline();
    }
  }

  Future<void> getAllUnits() async {
    emit(GetUnitLoading());
    List<UnitModel> allUnits = [];
    for (final unit in units.entries) {
      allUnits.addAll(unit.value);
    }
    emit(GetUnitSuccess(units: allUnits));
  }
}
