import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/general%20repo/general_repo.dart';
import 'package:equatable/equatable.dart';

part 'refresh_stored_data_state.dart';

class RefreshStoredDataCubit extends SafeCubit<RefreshStoredDataState> {
  RefreshStoredDataCubit(this.generalRepo) : super(RefreshStoredDataInitial());
  GeneralRepo generalRepo;

  Future<void> refreshAllStoredData() async {
    emit(RefreshStoredDataLoading());
    var result = await generalRepo.getOfflineData();
    result.fold((failure) {
      emit(RefreshStoredDataFailure(failure.errMessage));
    }, (_) {
      emit(RefreshStoredDataSuccess());
    });
  }
}
