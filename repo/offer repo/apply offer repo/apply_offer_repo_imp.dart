import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/apply%20offer%20repo/app_offer_repo.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/offer_model/offer_model.dart';
import 'package:almonazim/data/model/offer_model/total_offer_model.dart';
import 'package:almonazim/data/model/unit_model.dart';

class ApplyOfferImp extends AppLyOffer {
  UnitRepoImpl unitRepoImpl;
  ApplyOfferImp(this.unitRepoImpl);
  @override
  void applyNormalOffer(OfferModel offerModel, TotalOfferModel totalModel) {
    applyFinished(offerModel, totalModel);
  }

  @override
  void applyBogoOffer(OfferModel offerModel, TotalOfferModel totalModel) {
    double productCountConversion = unitRepoImpl
        .completeUnitModel(UnitModel(
            unitsId: offerModel.offersBogoDetailsModel!
                .offersConditionsBogoProductCountUnitId))
        .unitsConversionFactor!
        .toDouble();
    double countAfterConvert = totalModel.count! * totalModel.conversion!;
    double conditionCountAfterConvert =
        offerModel.offersBogoDetailsModel!.offersConditionsBogoProductCount! *
            productCountConversion;
    if (countAfterConvert >= conditionCountAfterConvert) {
      var repeatTimes = countAfterConvert / conditionCountAfterConvert;
      // no need to check if there are digits, just convert it to int
      int addedCount = repeatTimes.toInt() *
          offerModel.offersBogoDetailsModel!
              .offersConditionsBogoAffectedProductCount!;
      totalModel.count =
          totalModel.count! + addedCount; // the count has been edited
      // edit the  total undiscounted price
      totalModel.undiscountedPrice =
          totalModel.unitPrice! * totalModel.conversion! * totalModel.count!;
      // now go to discounts
      applyBogoDiscount(offerModel, addedCount, totalModel);
    } else {
      return;
    }
  }

  void applyBogoDiscount(
      OfferModel offer, int affectedCount, TotalOfferModel totalModel) {
    double totalDiscount =
        affectedCount * // we did not consider the unit of affected count this time
            totalModel.unitPrice! *
            // percentage discount
            offer.offersDiscountValue!.toDouble() /
            100;
    totalModel.discountedPrice = totalModel.undiscountedPrice -
        totalDiscount; // using undiscounted losing the ability to fit with multiple offers for one product
  } // because the count has been changed but //! there is not problem if the bogo is only applied on this product and no other offers are applied on this product only

  @override
  void applyOffer(TotalOfferModel totalModel) {
    if (totalModel.productsId != null && offers[OfferDomainType.one] != null) {
      List<OfferModel> productOffers = [];
      for (final offer in offers[OfferDomainType.one]!) {
        if (offer.offersDomainDetailsModel!.offersDomainProductsId ==
            totalModel.productsId) {
          productOffers.add(offer);
        }
      }
      applyAccordingToType(productOffers, totalModel);
    } else {
      // the domain is all or category or multiple
      if (offers[OfferDomainType.all] != null) {
        applyAccordingToType(offers[OfferDomainType.all]!, totalModel);
      }
    }
  }

  void applyAccordingToType(
      List<OfferModel> relatedOffers, TotalOfferModel totalModel) {
    for (final offer in relatedOffers) {
      if (offer.offersConditionsType == OffersConditionsType.normal.name) {
        applyNormalOffer(offer, totalModel);
      } else if (offer.offersConditionsType == OffersConditionsType.bogo.name) {
        applyBogoOffer(offer, totalModel);
      } else if (offer.offersConditionsType ==
          OffersConditionsType.volume.name) {
        applyVolumeOffer(offer, totalModel);
      } else if (offer.offersConditionsType ==
          OffersConditionsType.bundle.name) {
        // applyBundleOffer();
      } else {
        print("no way");
      }
    }
  }

  void applyFinished(OfferModel offer, TotalOfferModel totalProductModel) {
    if (offer.offersDiscountType == OfferDiscountType.percentage.name) {
      totalProductModel.discountedPrice -= totalProductModel.discountedPrice *
          offer.offersDiscountValue!.toDouble() /
          100;
    } else {
      totalProductModel.discountedPrice -=
          offer.offersDiscountValue!.toDouble();
    }
    if (!appliedOffers.contains(offer)) {
      appliedOffers.add(offer);
    }
  }

  @override
  void applyVolumeOffer(OfferModel offerModel, TotalOfferModel totalModel) {
    if (offerModel
            .offersVolumeDetailsModel!.offersConditionsVolumeMinimumValueType ==
        OfferVolumeMinimumType.price.name) {
      if (offerModel
              .offersVolumeDetailsModel!.offersConditionsVolumeMinimumValue!
              .toDouble() <=
          totalModel.undiscountedPrice) {
        applyFinished(offerModel, totalModel);
      } else {
        appliedOffers.remove(offerModel);
        return;
      }
    } else {
      if (offerModel
              .offersVolumeDetailsModel!.offersConditionsVolumeMinimumValue!
              .toDouble() <=
          totalModel.count!) {
        // compare it to count
        applyFinished(offerModel, totalModel);
      } else {
        appliedOffers.remove(offerModel);
        return;
      }
    }
  }
}
