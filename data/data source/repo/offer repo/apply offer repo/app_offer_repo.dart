import 'package:almonazim/data/model/offer_model/offer_model.dart';
import 'package:almonazim/data/model/offer_model/total_offer_model.dart';

abstract class AppLyOffer {
  void applyNormalOffer(OfferModel offerModel, TotalOfferModel totalModel);
  void applyBogoOffer(OfferModel offerModel, TotalOfferModel totalModel);
  void applyVolumeOffer(OfferModel offerModel, TotalOfferModel totalModel);

  void applyOffer(TotalOfferModel totalModel);
}
