import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo_imp.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_revenue_state.dart';

class AddRevenueCubit extends SafeCubit<AddRevenueState> {
  AddRevenueCubit(this.revenuesRepoImpl) : super(AddRevenueInitial());
  RevenuesRepoImpl revenuesRepoImpl;
  RevenueInputModel revenueInputModel =
      RevenueInputModel(revenuesCreatedAt: DateTime.now().toString());
  Future<void> addRevenue() async {
    prepareBaseAmount();
    emit(AddRevenueLoading());
    var result = await revenuesRepoImpl.addRevenue(revenueInputModel);
    result.fold((failure) {
      emit(AddRevenueFailure(failure.errMessage));
    }, (_) {
      emit(const AddRevenueSuccess());
    });
  }

  void prepareBaseAmount() {
    if (revenueInputModel.revenuesAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      revenueInputModel.revenuesAmountInBase = convertAmountToBase(
          revenueInputModel.revenuesAmount!,
          revenueInputModel.revenuesAmountCurrencyId!);
    }
  }

  String? get validateDataMessage {
    if (revenueInputModel.revenuesAccountId == null) {
      return "الرجاء اختيار المجموعة";
    } else if (revenueInputModel.revenuesAmount == null ||
        revenueInputModel.revenuesAmount == 0) {
      return "الرجاء إدخال المبلغ";
    } else if (revenueInputModel.revenuesName == null ||
        revenueInputModel.revenuesName!.isEmpty) {
      return "الرجاء إدخال عنوان الإيراد";
    } else {
      return null;
    }
  }
}
