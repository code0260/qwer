import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'refresh_prices_state.dart';

class RefreshPriceCubit extends SafeCubit<RefreshPriceState> {
  RefreshPriceCubit(this.productRepo) : super(RefreshPriceInitial());
  PricesRepoImpl productRepo;
  Future<void> refreshPrices() async {
    emit(RefreshPriceLoading());
    var result = await productRepo.getSellPrices();
    result.fold((failure) {
      emit(RefreshPriceFailure(failure.errMessage));
    }, (_) {
      emit(RefreshPriceSuccess());
    });
  }
}
