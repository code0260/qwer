// ignore_for_file: public_member_api_docs, sort_constructors_first

class SalarySlipSummaryModel {
  double? basicSalary;
  double? totalBonuses;
  double? totalDeductions;
  double? finalResult;
  int? currencyId;
  SalarySlipSummaryModel(
      {this.basicSalary,
      this.totalBonuses,
      this.totalDeductions,
      this.finalResult,
      this.currencyId});

  SalarySlipSummaryModel copyWith(
      {double? basicSalary,
      double? totalBonuses,
      double? totalDeductions,
      double? finalResult,
      int? currencyId}) {
    return SalarySlipSummaryModel(
        basicSalary: basicSalary ?? this.basicSalary,
        totalBonuses: totalBonuses ?? this.totalBonuses,
        totalDeductions: totalDeductions ?? this.totalDeductions,
        finalResult: finalResult ?? this.finalResult,
        currencyId: currencyId ?? this.currencyId);
  }

  @override
  bool operator ==(covariant SalarySlipSummaryModel other) {
    if (identical(this, other)) return true;

    return other.basicSalary == basicSalary &&
        other.totalBonuses == totalBonuses &&
        other.totalDeductions == totalDeductions &&
        other.finalResult == finalResult &&
        other.currencyId == currencyId;
  }

  @override
  int get hashCode {
    return basicSalary.hashCode ^
        totalBonuses.hashCode ^
        totalDeductions.hashCode ^
        finalResult.hashCode ^
        currencyId.hashCode;
  }
}
