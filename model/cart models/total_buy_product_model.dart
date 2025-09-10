// ignore_for_file: public_member_api_docs, sort_constructors_first
class TotalBuyProductModel {
  int? productsId;
  double? totalProduct;
  double? buyPrice;
  double taxAmount; // Added property
  int? currencyId;
  double? currencyConversion;

  TotalBuyProductModel({
    this.productsId,
    this.totalProduct,
    this.buyPrice,
    this.currencyConversion,
    this.currencyId,
    this.taxAmount = 0, // Added property
  });

  @override
  String toString() =>
      'TotalProductModel(productsId: $productsId, totalProduct: $totalProduct, buyPrice: $buyPrice, taxAmount: $taxAmount)'; // Added taxAmount to string representation

  @override
  bool operator ==(covariant TotalBuyProductModel other) {
    if (identical(this, other)) return true;

    return other.productsId == productsId &&
        other.totalProduct == totalProduct &&
        other.buyPrice == buyPrice &&
        other.taxAmount == taxAmount &&
        other.currencyId == currencyId &&
        other.currencyConversion == currencyConversion;
  }

  @override
  int get hashCode {
    return productsId.hashCode ^
        totalProduct.hashCode ^
        buyPrice.hashCode ^
        taxAmount.hashCode ^
        currencyId.hashCode ^
        currencyConversion.hashCode;
  }
}
