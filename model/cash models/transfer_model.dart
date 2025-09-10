class TransferModel {
  int? fromCurrencyId;
  int? toCurrencyId;
  double feesAmount;
  double? feesAmountInBase;
  double? transferredAmountInFrom;
  double? transferredAmountInTo;

  TransferModel(
      {this.fromCurrencyId,
      this.toCurrencyId,
      this.feesAmount = 0,
      this.feesAmountInBase,
      this.transferredAmountInFrom,
      this.transferredAmountInTo});

  TransferModel copyWith({
    int? fromCurrencyId,
    int? toCurrencyId,
    double? feesAmount,
    double? feesAmountInBase,
    double? transferredAmountInFrom,
    double? transferredAmountInTo,
  }) {
    return TransferModel(
      fromCurrencyId: fromCurrencyId ?? this.fromCurrencyId,
      toCurrencyId: toCurrencyId ?? this.toCurrencyId,
      feesAmount: feesAmount ?? this.feesAmount,
      feesAmountInBase: feesAmountInBase ?? this.feesAmountInBase,
      transferredAmountInFrom:
          transferredAmountInFrom ?? this.transferredAmountInFrom,
      transferredAmountInTo:
          transferredAmountInTo ?? this.transferredAmountInTo,
    );
  }

  @override
  bool operator ==(covariant TransferModel other) {
    if (identical(this, other)) return true;

    return other.fromCurrencyId == fromCurrencyId &&
        other.toCurrencyId == toCurrencyId &&
        other.feesAmount == feesAmount &&
        other.feesAmountInBase == feesAmountInBase &&
        other.transferredAmountInFrom == transferredAmountInFrom &&
        other.transferredAmountInTo == transferredAmountInTo;
  }

  @override
  int get hashCode {
    return fromCurrencyId.hashCode ^
        toCurrencyId.hashCode ^
        feesAmount.hashCode ^
        feesAmountInBase.hashCode ^
        transferredAmountInFrom.hashCode ^
        transferredAmountInTo.hashCode;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'fromCurrencyId': fromCurrencyId,
      'toCurrencyId': toCurrencyId,
      'feesAmount': feesAmount,
      'feesAmountInBase': feesAmountInBase,
      'transferredAmountInFrom': transferredAmountInFrom,
      'transferredAmountInTo': transferredAmountInTo,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
