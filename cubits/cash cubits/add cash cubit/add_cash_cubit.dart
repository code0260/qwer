import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/cash%20repo/cash_repo.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_cash_state.dart';

class AddCashCubit extends SafeCubit<AddCashState> {
  AddCashCubit(this.cashRepo) : super(AddCashInitial());
  CashRepo cashRepo;
  List<CashInputModel> cashModels = [];
  Future<void> addCash() async {
    emit(AddCashLoading());
    var response = await cashRepo.addCash(cashModels);
    response.fold((failure) {
      emit(AddCashFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(AddCashSuccess());
    });
  }

  String? get validateData {
    if (cashModels.length != currencies.length) {
      return 'هناك عملة ناقصة';
    }
    if (cashModels[0].cashAmount == null || cashModels[0].cashAmount == null) {
      return 'الرجاء إدخال قيمة للعملة الأساسية';
    }
    return null;
  }
}
