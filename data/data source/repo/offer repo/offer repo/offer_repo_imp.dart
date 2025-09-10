import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/offer%20repo/offer_repo.dart';
import 'package:almonazim/data/model/offer_model/get_offer_model.dart';
import 'package:dartz/dartz.dart';

class OfferRepoImp implements OfferRepo {
  ApiService apiService;
  OfferRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> getAllOffers() async {
    // var result = await apiService.get(
    //   url: AppLinks.getAllOffersLink,
    // );

    // return result.fold((failure) {
    //   return left(failure);
    // }, (response) {
    //   for (final item in response["data"]) {
    //     offers[(item["offers_domain_type"] as String).toDomainType()] = [];
    //     for (final offer in item["offers"]) {
    //       offers[(offer["offers_domain_type"] as String).toDomainType()]!
    //           .add(OfferModel.fromJson(offer));
    //     }
    //   }
    //   return right("success");
    // });
    return left(ServerFailure('لا يوجد عروض'));
  }

  @override
  Future<Either<Failure, List<GetOfferModel>>> getOffersByDomain(
      OfferDomainType domainType) async {
    if (offersToShow[domainType] == null) {
      var result = await apiService.post(
        url: AppLinks.getOffersByDomainLink,
        data: {
          "domain": domainType.name,
        },
      );

      return result.fold((failure) {
        return left(failure);
      }, (response) {
        List<GetOfferModel> offersLocale = [];
        for (final offer in response["data"]) {
          offersLocale.add(GetOfferModel.fromJson(offer));
        }
        offersToShow[domainType] = offersLocale;
        return right(offersToShow[domainType]!);
      });
    } else {
      return right(offersToShow[domainType]!);
    }
  }
}
