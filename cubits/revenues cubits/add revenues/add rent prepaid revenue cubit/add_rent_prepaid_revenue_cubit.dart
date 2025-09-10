import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo_imp.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_rent_prepaid_revenue_state.dart';

class AddRentPrepaidRevenueCubit extends SafeCubit<AddRentPrepaidRevenueState> {
  AddRentPrepaidRevenueCubit(this.revenuesRepoImpl)
      : super(AddRentPrepaidRevenueInitial());

  final RevenuesRepoImpl revenuesRepoImpl;
  RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel =
      RentPrepaidRevenueInputModel(
          rentPrepaidRevenuesCreatedAt: DateTime.now().toString());

  Future<void> addRentPrepaidRevenue() async {
    prepareBaseAmount();
    emit(AddRentPrepaidRevenueLoading());
    var result = await revenuesRepoImpl
        .addRentPrepaidRevenue(rentPrepaidRevenueInputModel);
    result.fold((failure) {
      emit(AddRentPrepaidRevenueFailure(failure.errMessage));
    }, (_) {
      emit(const AddRentPrepaidRevenueSuccess());
    });
  }

  void prepareBaseAmount() {
    if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmountInBase =
          convertAmountToBase(
              rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmount!,
              rentPrepaidRevenueInputModel
                  .rentPrepaidRevenuesAmountCurrencyId!);
    } else {
      rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesAccountsId == null) {
      return "الرجاء اختيار الحساب";
    } else if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmount == null ||
        rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmount == 0) {
      return "الرجاء إدخال المبلغ";
    } else if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesName == null ||
        rentPrepaidRevenueInputModel.rentPrepaidRevenuesName!.isEmpty) {
      return "الرجاء إدخال اسم الإيراد المدفوع مقدماً";
    } else if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesMonthCount ==
        null) {
      return "الرجاء إدخال عدد الأشهر";
    } else if (rentPrepaidRevenueInputModel.rentPrepaidRevenuesStartDate ==
            null ||
        rentPrepaidRevenueInputModel.rentPrepaidRevenuesStartDate!.isEmpty) {
      return "الرجاء اختيار تاريخ البداية";
    } else {
      return null;
    }
  }
}
