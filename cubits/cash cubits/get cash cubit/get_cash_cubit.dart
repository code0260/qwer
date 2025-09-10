import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/cash%20repo/cash_repo_imp.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/cash%20models/get_all_cash_model.dart';
import 'package:equatable/equatable.dart';

part 'get_cash_state.dart';

class GetCashCubit extends SafeCubit<GetCashState> {
  GetCashCubit(this.cashRepo) : super(GetCashInitial());
  CashRepoImpl cashRepo;
  CashInputModel cashInputModel = CashInputModel();
  Future<void> getCash() async {
    emit(GetCashLoading());
    var result = await cashRepo.getCash(cashInputModel);
    result.fold((failure) {
      emit(GetCashFailure(failure.errMessage));
    }, (cash) {
      emit(GetCashSuccess(getAllCashModel: cash));
    });
  }
}
