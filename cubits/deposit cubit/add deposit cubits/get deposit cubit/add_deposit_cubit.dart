import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/deposit%20repo/deposit_repo.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_deposit_state.dart';

class AddDepositCubit extends SafeCubit<AddDepositState> {
  AddDepositCubit(this.depositRepo) : super(AddDepositInitial());
  DepositRepo depositRepo;
  DepositInputModel depositInputModel = DepositInputModel(
    depositsCreatedAt: DateTime.now().toString(),
  );
  Future<void> addDeposit() async {
    prepareBaseAmount();
    emit(AddDepositLoading());
    var result = await depositRepo.addDeposit(depositInputModel);
    result.fold((failure) {
      emit(AddDepositFailure(failure.errMessage));
    }, (_) {
      emit(const AddDepositSuccess());
    });
  }

  void prepareBaseAmount() {
    if (depositInputModel.depositsAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      depositInputModel.depositsAmountInBase = convertAmountToBase(
          depositInputModel.depositsCashAmount!,
          depositInputModel.depositsAmountCurrencyId!);
    } else {
      depositInputModel.depositsAmountInBase = null;
    }
  }
}
