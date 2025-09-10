import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_business_currency.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo.dart';
import 'package:almonazim/data/model/currency%20models/currency_input_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'edit_currency_state.dart';

class EditCurrencyCubit extends SafeCubit<EditCurrencyState> {
  EditCurrencyCubit(this.currencyRepo) : super(EditCurrencyInitial());
  CurrencyRepo currencyRepo;
  CurrencyInputModel currencyInputModel = CurrencyInputModel();
  bool isAuto = true;
  Future<void> editCurrency() async {
    emit(EditCurrencyLoading());
    Either<Failure, void> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      currencyInputModel.businessCurrencyBusinessId =
          StoreUserModel.instance.businessId;
      currencyInputModel.businessCurrencyOnline = 0;
      result = await StoreBusinessCurrency.updateBusinessCurrencyData(
          currencyInputModel.toJson());
    } else {
      result = await currencyRepo.editCurrency(currencyInputModel);
    }
    result.fold((failure) {
      emit(EditCurrencyFailure(failure.errMessage));
    }, (_) {
      emit(EditCurrencySuccess());
    });
  }

  // String? get validateCurrencyDataMessage {
  //   if (currencyInputModel.currenciesName == null ||
  //       currencyInputModel.currenciesName!.isEmpty) {
  //     return "الرجاء إدخال اسم العميل";
  //   } else if (currencyInputModel.currenciesType == null ||
  //       currencyInputModel.currenciesType!.isEmpty) {
  //     return "الرجاء اختيار نوع العميل";
  //   } else {
  //     return null;
  //   }
  // }
}
