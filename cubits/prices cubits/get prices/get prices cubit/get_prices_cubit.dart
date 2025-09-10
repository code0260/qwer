import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/prices%20functions/translate_prices_partner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo_imp.dart';
import 'package:almonazim/data/model/price%20models/all_prices_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:equatable/equatable.dart';

part 'get_prices_state.dart';

class GetPricesCubit extends SafeCubit<GetPricesState> {
  GetPricesCubit(this.pricesRepo) : super(GetPricesInitial());
  PricesRepoImpl pricesRepo;
  PriceInputModel priceInputModel = PriceInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 1 * 30)),
      endDate: DateTime.now(),
      pricesPartnerAr:
          translateToArPricesPartnerFromString(PricesPartner.price1.name));
  Future<void> getPricesInfo() async {
    emit(GetPricesLoading());
    var result = await pricesRepo.getPricesInfo(priceInputModel);
    result.fold((failure) {
      emit(GetPricesFailure(failure.errMessage));
    }, (allPricesModel) {
      emit(GetPricesSuccess(allPricesModel: allPricesModel));
    });
  }
}
