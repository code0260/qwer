// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/model/invoice%20models/shipping_input_model.dart';

class TotalPriceModel {
  double undiscountedPrice;
  double discountedPrice;
  double shippingCost;
  ShippingInputModel? shippingInputModel;
  double totalTaxAmount; // Added property
  int? currencyId;
  double discountValue;
  OfferDiscountType discountType;
  TotalPriceModel({
    this.undiscountedPrice = 0,
    this.discountedPrice = 0,
    this.shippingCost = 0,
    this.shippingInputModel,
    this.currencyId,
    this.discountType = OfferDiscountType.percentage,
    this.totalTaxAmount = 0, // Added property
    this.discountValue = 0, // Added property
  });

  @override
  int get hashCode {
    return undiscountedPrice.hashCode ^
        discountedPrice.hashCode ^
        shippingCost.hashCode ^
        shippingInputModel.hashCode ^
        totalTaxAmount.hashCode ^
        currencyId.hashCode ^
        discountValue.hashCode ^
        discountType.hashCode;
  }

  TotalPriceModel copyWith(
      {double? undiscountedPrice,
      double? discountedPrice,
      double? shippingCost,
      double? totalTaxAmount,
      double? discountValue,
      OfferDiscountType? discountType,
      ShippingInputModel? shippingInputModel,
      int? currencyId}) {
    return TotalPriceModel(
      undiscountedPrice: undiscountedPrice ?? this.undiscountedPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountValue: discountValue ?? this.discountValue,
      discountType: discountType ?? this.discountType,
      shippingCost: shippingCost ?? this.shippingCost,
      shippingInputModel: shippingInputModel ?? this.shippingInputModel,
      totalTaxAmount: totalTaxAmount ?? this.totalTaxAmount,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  @override
  bool operator ==(covariant TotalPriceModel other) {
    if (identical(this, other)) return true;

    return other.undiscountedPrice == undiscountedPrice &&
        other.discountedPrice == discountedPrice &&
        other.shippingCost == shippingCost &&
        other.shippingInputModel == shippingInputModel &&
        other.totalTaxAmount == totalTaxAmount &&
        other.currencyId == currencyId &&
        other.discountValue == discountValue &&
        other.discountType == discountType;
  }
}
