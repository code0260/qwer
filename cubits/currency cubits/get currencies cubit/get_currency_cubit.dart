import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/currency%20repo/currency_repo_imp.dart';
import 'package:almonazim/data/model/currency%20models/currency_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_currency_state.dart';

class GetCurrencyCubit extends SafeCubit<GetCurrencyState> {
  GetCurrencyCubit(this.currencyRepo) : super(GetCurrencyInitial());
  CurrencyRepoImpl currencyRepo;
  Future<void> getCurrencies() async {
    emit(GetCurrencyLoading());
    Either<Failure, List<CurrencyModel>> result;
    result = await currencyRepo.getCurrencies();
    result.fold((failure) {
      emit(GetCurrencyFailure(failure.errMessage));
    }, (currencies) {
      emit(GetCurrencySuccess(currencies: currencies));
    });
  }
}
