import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/offer%20repo/offer_repo_imp.dart';
import 'package:almonazim/data/model/offer_model/get_offer_model.dart';
import 'package:equatable/equatable.dart';

part 'get_offers_state.dart';

class GetOfferCubit extends SafeCubit<GetOfferState> {
  GetOfferCubit(this.offerRepo) : super(GetOfferInitial());
  OfferRepoImp offerRepo;
  Future<void> getOffer(OfferDomainType domainType) async {
    emit(GetOfferLoading());
    var result = await offerRepo.getOffersByDomain(domainType);
    result.fold((failure) {
      emit(GetOfferFailure(failure.errMessage));
    }, (offers) {
      emit(GetOfferSuccess(offers: offers));
    });
  }
}
