import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo.dart';
import 'package:almonazim/data/model/currency%20models/currency_input_model.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_currency_state.dart';

class AddCurrencyCubit extends SafeCubit<AddCurrencyState> {
  AddCurrencyCubit(this.currencyRepo) : super(AddCurrencyInitial());
  CurrencyRepo currencyRepo;
  CurrencyInputModel currencyInputModel = CurrencyInputModel();
  bool isAuto = true;
  Future<void> addCurrency() async {
    emit(AddCurrencyLoading());
    Either<Failure, void> result;
    result = await currencyRepo.addCurrency(currencyInputModel);
    result.fold((failure) {
      emit(AddCurrencyFailure(failure.errMessage));
    }, (_) {
      emit(const AddCurrencySuccess());
    });
  }

  void assignCurrency(CurrencyModel currencyModel) {
    currencyInputModel.businessCurrencyCurrenciesId =
        currencyModel.currenciesId!;
    emit(AddCurrencyChanged(currencyModel: currencyModel));
  }

  String? get validateDataMessage {
    if (currencyInputModel.businessCurrencyCurrenciesId == null) {
      return "الرجاء اختيار العملة";
    } else if (currencyInputModel.businessCurrencyNearFactor == null) {
      return "الرجاء اختيار عامل تقريب العملة";
    } else {
      return null;
    }
  }
}
