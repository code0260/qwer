// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_enums.dart';

class TotalOfferModel {
  int? productsId;
  double undiscountedPrice;
  double discountedPrice;
  double? count;
  double? unitPrice;
  int? currencyId;
  double? currencyConversion;
  double? conversion;
  double shippingCost; // Added property
  double taxAmount; // Added property
  double discountValue;
  OfferDiscountType discountType;

  TotalOfferModel({
    this.productsId,
    this.undiscountedPrice = 0,
    this.count,
    this.conversion,
    this.currencyConversion,
    this.currencyId,
    this.unitPrice,
    this.discountedPrice = 0,
    this.shippingCost = 0, // Added property
    this.taxAmount = 0, // Added property
    this.discountType = OfferDiscountType.percentage,
    this.discountValue = 0, // Added property
  });

  TotalOfferModel copyWith({
    int? productsId,
    double? undiscountedPrice,
    double? discountedPrice,
    double? count,
    double? unitPrice,
    double? conversion,
    double? shippingCost,
    double? taxAmount, // Added property
    double? discountValue,
    OfferDiscountType? discountType,
  }) {
    return TotalOfferModel(
      discountValue: discountValue ?? this.discountValue,
      discountType: discountType ?? this.discountType,
      productsId: productsId ?? this.productsId,
      undiscountedPrice: undiscountedPrice ?? this.undiscountedPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      count: count ?? this.count,
      unitPrice: unitPrice ?? this.unitPrice,
      conversion: conversion ?? this.conversion,
      shippingCost: shippingCost ?? this.shippingCost,
      taxAmount: taxAmount ?? this.taxAmount, // Added property
    );
  }

  @override
  bool operator ==(covariant TotalOfferModel other) {
    if (identical(this, other)) return true;

    return other.productsId == productsId &&
        other.undiscountedPrice == undiscountedPrice &&
        other.discountedPrice == discountedPrice &&
        other.count == count &&
        other.unitPrice == unitPrice &&
        other.currencyId == currencyId &&
        other.currencyConversion == currencyConversion &&
        other.conversion == conversion &&
        other.shippingCost == shippingCost &&
        other.taxAmount == taxAmount &&
        other.discountValue == discountValue &&
        other.discountType == discountType;
  }

  @override
  int get hashCode {
    return productsId.hashCode ^
        undiscountedPrice.hashCode ^
        discountedPrice.hashCode ^
        count.hashCode ^
        unitPrice.hashCode ^
        currencyId.hashCode ^
        currencyConversion.hashCode ^
        conversion.hashCode ^
        shippingCost.hashCode ^
        taxAmount.hashCode ^
        discountValue.hashCode ^
        discountType.hashCode;
  }
}
