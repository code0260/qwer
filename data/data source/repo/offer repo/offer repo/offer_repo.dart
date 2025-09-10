import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/offer_model/get_offer_model.dart';
import 'package:dartz/dartz.dart';

abstract class OfferRepo {
  Future<Either<Failure, List<GetOfferModel>>> getOffersByDomain(
      OfferDomainType domainType);
  Future<Either<Failure, String>> getAllOffers();
}
