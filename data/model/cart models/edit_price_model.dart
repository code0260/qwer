// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditPriceModel {
  int? productsId;
  double? price;
  int? currencyId;
  double? currencyConversion;
  EditPriceModel({
    this.productsId,
    this.price,
    this.currencyConversion,
    this.currencyId,
  });

  @override
  bool operator ==(covariant EditPriceModel other) {
    if (identical(this, other)) return true;

    return other.productsId == productsId &&
        other.price == price &&
        other.currencyId == currencyId &&
        other.currencyConversion == currencyConversion;
  }

  @override
  int get hashCode {
    return productsId.hashCode ^
        price.hashCode ^
        currencyId.hashCode ^
        currencyConversion.hashCode;
  }
}
