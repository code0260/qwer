import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_currencies.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo_imp.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_business_currency_state.dart';

class GetBusinessCurrencyCubit extends SafeCubit<GetBusinessCurrencyState> {
  GetBusinessCurrencyCubit(this.currencyRepo)
      : super(GetBusinessCurrencyInitial());
  CurrencyRepoImpl currencyRepo;
  Future<void> getBusinessCurrencies() async {
    emit(GetBusinessCurrencyLoading());
    if (currencies.isEmpty) {
      Either<Failure, List<CurrencyModel>> result;
      if (StoreWorkOffline.getWorkOffline() == true) {
        result = await StoreCurrencies.getAllCurrencies();
      } else {
        result = await currencyRepo.getBusinessCurrencies();
      }
      result.fold((failure) {
        emit(GetBusinessCurrencyFailure(failure.errMessage));
      }, (gotCurrencies) {
        currencies = gotCurrencies;
        emit(GetBusinessCurrencySuccess(currencies: gotCurrencies));
      });
    } else {
      emit(GetBusinessCurrencySuccess(currencies: currencies));
    }
  }

  Future<void> refreshAllCurrencies() async {
    emit(GetBusinessCurrencyLoading());
    var result = await currencyRepo.getBusinessCurrencies();
    result.fold((failure) {
      emit(GetBusinessCurrencyFailure(failure.errMessage));
    }, (gotCurrencies) {
      currencies = gotCurrencies;
      emit(GetBusinessCurrencySuccess(currencies: gotCurrencies));
    });
  }
}
