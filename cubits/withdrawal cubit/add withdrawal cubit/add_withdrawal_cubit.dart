import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/withdrawal%20repo/withdrawal_repo.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_withdrawal_state.dart';

class AddWithdrawalCubit extends SafeCubit<AddWithdrawalState> {
  AddWithdrawalCubit(this.withdrawalRepo) : super(AddWithdrawalInitial());
  WithdrawalRepo withdrawalRepo;
  WithdrawalInputModel withdrawalInputModel = WithdrawalInputModel(
      withdrawalsCreatedAt: DateTime.now().toString(),
      withdrawalsType: WithdrawalType.cash.name);
  Future<void> addWithdrawal() async {
    prepareBaseAmount();
    emit(AddWithdrawalLoading());
    var result = await withdrawalRepo.addWithdrawal(withdrawalInputModel);
    result.fold((failure) {
      emit(AddWithdrawalFailure(failure.errMessage));
    }, (_) {
      emit(const AddWithdrawalSuccess());
    });
  }

  void prepareBaseAmount() {
    if (withdrawalInputModel.withdrawalsAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      withdrawalInputModel.withdrawalsAmountInBase = convertAmountToBase(
          withdrawalInputModel.withdrawalsCashAmount!,
          withdrawalInputModel.withdrawalsAmountCurrencyId!);
    } else {
      withdrawalInputModel.withdrawalsAmountInBase = null;
    }
  }
}
