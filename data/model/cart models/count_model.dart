class CountProductModel {
  int? productsId;
  double? count;
  CountProductModel({
    this.productsId,
    this.count,
  });

  @override
  bool operator ==(covariant CountProductModel other) {
    if (identical(this, other)) return true;

    return other.productsId == productsId && other.count == count;
  }

  @override
  int get hashCode => productsId.hashCode ^ count.hashCode;
}
