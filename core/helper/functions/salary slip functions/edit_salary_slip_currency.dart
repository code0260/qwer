import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';

SalarySlipModel editSalarySlipCurrency(
    int id, SalarySlipModel salarySlipModel) {
  var baseCurrencyId = currencies
      .firstWhere(
        (element) => element.businessCurrencyIsBase == 1,
      )
      .businessCurrencyId;
  if (id == baseCurrencyId &&
      salarySlipModel.salarySlipAmountCurrencyId != baseCurrencyId) {
    Map<String, dynamic> map = salarySlipModel.toMap();
    map.remove("salary_slip_net_salary_in_base");
    salarySlipModel = SalarySlipModel.fromJson(map);
    salarySlipModel = salarySlipModel.copyWith(
        salarySlipAmountCurrencyId: id,
        salarySlipTotalAllowances: convertAmountToBase(
            salarySlipModel.salarySlipTotalAllowances!,
            salarySlipModel.salarySlipAmountCurrencyId!),
        salarySlipTotalDeductions: convertAmountToBase(
            salarySlipModel.salarySlipTotalDeductions!,
            salarySlipModel.salarySlipAmountCurrencyId!),
        salarySlipNetSalary: convertAmountToBase(
            salarySlipModel.salarySlipNetSalary!,
            salarySlipModel.salarySlipAmountCurrencyId!));
  } else {
    salarySlipModel = salarySlipModel.copyWith(
        salarySlipAmountCurrencyId: id,
        salarySlipTotalAllowances: convertAmount(
            salarySlipModel.salarySlipTotalAllowances!,
            salarySlipModel.salarySlipAmountCurrencyId!,
            id),
        salarySlipTotalDeductions: convertAmount(
            salarySlipModel.salarySlipTotalDeductions!,
            salarySlipModel.salarySlipAmountCurrencyId!,
            id),
        salarySlipNetSalary: convertAmount(salarySlipModel.salarySlipNetSalary!,
            salarySlipModel.salarySlipAmountCurrencyId!, id),
        salarySlipNetSalaryInBase: convertAmountToBase(
            salarySlipModel.salarySlipNetSalary!,
            salarySlipModel.salarySlipAmountCurrencyId!));
  }
  return salarySlipModel;
}
