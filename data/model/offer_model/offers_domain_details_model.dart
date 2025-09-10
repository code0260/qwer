import 'package:equatable/equatable.dart';

class OffersDomainDetailsModel extends Equatable {
  final int? offersDomainId;
  final int? offersDomainOffersId;
  final int? offersDomainProductsId;
  final dynamic offersDomainProductsCategoriesId;

  const OffersDomainDetailsModel({
    this.offersDomainId,
    this.offersDomainOffersId,
    this.offersDomainProductsId,
    this.offersDomainProductsCategoriesId,
  });

  factory OffersDomainDetailsModel.fromJson(Map<String, dynamic> json) {
    return OffersDomainDetailsModel(
      offersDomainId: json['offers_domain_id'] as int?,
      offersDomainOffersId: json['offers_domain_offers_id'] as int?,
      offersDomainProductsId: json['offers_domain_products_id'] as int?,
      offersDomainProductsCategoriesId:
          json['offers_domain_products_categories_id'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'offers_domain_id': offersDomainId,
        'offers_domain_offers_id': offersDomainOffersId,
        'offers_domain_products_id': offersDomainProductsId,
        'offers_domain_products_categories_id':
            offersDomainProductsCategoriesId,
      };

  @override
  List<Object?> get props {
    return [
      offersDomainId,
      offersDomainOffersId,
      offersDomainProductsId,
      offersDomainProductsCategoriesId,
    ];
  }
}
