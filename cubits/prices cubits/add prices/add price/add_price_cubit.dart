import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/prices%20functions/translate_prices_partner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/prices%20repo/prices_repo.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_price_state.dart';

class AddPriceCubit extends SafeCubit<AddPriceState> {
  AddPriceCubit(this.pricesRepo) : super(AddPriceInitial());
  PricesRepo pricesRepo;
  PriceInputModel priceInputModel = PriceInputModel(
      pricesPartnerEn: PricesPartner.price1.name,
      pricesPartnerAr:
          translateToArPricesPartnerFromString(PricesPartner.price1.name),
      pricesCreatedAt: DateTime.now().toString());
  Future<void> addPrice() async {
    emit(AddPriceLoading());
    var result = await pricesRepo.addPrice(priceInputModel);
    result.fold((failure) {
      emit(AddPriceFailure(failure.errMessage));
    }, (_) {
      emit(const AddPriceSuccess());
    });
  }

  String? get validateDataMessage {
    if (priceInputModel.pricesType == null) {
      return "الرجاء اختيار نوع السعر";
    } else if (priceInputModel.pricesUnitPrice == null) {
      return "الرجاء إدخال سعر الواحدة";
    } else if (priceInputModel.pricesAmountCurrencyId == null) {
      return "الرجاء اختيار العملة";
    } else {
      return null;
    }
  }
}
