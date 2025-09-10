import 'package:almonazim/data/model/offer_model/offer_model.dart';

class GetOfferModel {
  final OfferModel offerModel;
  final String? productsName;
  final String? categoriesName;
  GetOfferModel({
    required this.offerModel,
    this.productsName,
    this.categoriesName,
  });

  factory GetOfferModel.fromJson(Map<String, dynamic> json) {
    return GetOfferModel(
      offerModel: OfferModel.fromJson(json['offer'] as Map<String, dynamic>),
      productsName: json['products_name'] != null
          ? json['products_name'] as String?
          : null,
      categoriesName: json['categories_name'] != null
          ? json['categories_name'] as String?
          : null,
    );
  }

  @override
  bool operator ==(covariant GetOfferModel other) {
    if (identical(this, other)) return true;

    return other.offerModel == offerModel &&
        other.productsName == productsName &&
        other.categoriesName == categoriesName;
  }

  @override
  int get hashCode =>
      offerModel.hashCode ^ productsName.hashCode ^ categoriesName.hashCode;
}
