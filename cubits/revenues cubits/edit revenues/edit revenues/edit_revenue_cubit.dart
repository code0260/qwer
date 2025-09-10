import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_revenue_state.dart';

class EditRevenuesCubit extends SafeCubit<EditRevenuesState> {
  EditRevenuesCubit(this.revenuesRepo) : super(EditRevenuesInitial());
  RevenuesRepo revenuesRepo;
  RevenueInputModel revenueInputModel = RevenueInputModel();

  Future<void> editRevenues(RevenuesModel revenuesModel) async {
    prepareCurrency();
    emit(EditRevenuesLoading());
    var result =
        await revenuesRepo.editRevenues(revenueInputModel, revenuesModel);
    result.fold((failure) {
      emit(EditRevenuesFailure(failure.errMessage));
    }, (_) {
      emit(EditRevenuesSuccess());
    });
  }

  void prepareCurrency() {
    if (revenueInputModel.revenuesAmountCurrencyId !=
        currencies
            .firstWhere((element) => element.businessCurrencyIsBase == 1)
            .businessCurrencyId) {
      if (revenueInputModel.revenuesSecondAmount != 0) {
        revenueInputModel.paidThisTimeInBase = convertAmountToBase(
            revenueInputModel.paidThisTime!,
            revenueInputModel.paidThisTimeCurrencyId!);
        revenueInputModel.revenuesSecondAmountInBase =
            (revenueInputModel.revenuesSecondAmountInBase ?? 0) +
                revenueInputModel.paidThisTimeInBase!;
      }
    } else {
      revenueInputModel.revenuesSecondAmountInBase = null;
      revenueInputModel.paidThisTimeInBase = null;
    }
  }

  void editCurrency(int id) {
    revenueInputModel.paidThisTimeCurrencyId = id;
    emit(EditRevenueCurrencyChanged(currencyId: id));
  }
}
