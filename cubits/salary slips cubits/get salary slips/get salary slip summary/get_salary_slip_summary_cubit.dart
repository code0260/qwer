import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_summary_model.dart';

class GetSalarySlipSummaryCubit extends SafeCubit<SalarySlipSummaryModel> {
  GetSalarySlipSummaryCubit()
      : super(SalarySlipSummaryModel(
            basicSalary: 0,
            totalBonuses: 0,
            totalDeductions: 0,
            currencyId: currencies
                .firstWhere(
                  (element) => element.businessCurrencyIsBase == 1,
                )
                .businessCurrencyId,
            finalResult: 0));
  SalarySlipSummaryModel salarySlipSummaryModel = SalarySlipSummaryModel(
      basicSalary: 0,
      totalBonuses: 0,
      totalDeductions: 0,
      finalResult: 0,
      currencyId: currencies
          .firstWhere(
            (element) => element.businessCurrencyIsBase == 1,
          )
          .businessCurrencyId);

  void insertData(
      {double? basicSalary, double? totalBonuses, double? totalDeductions}) {
    salarySlipSummaryModel = salarySlipSummaryModel.copyWith(
      basicSalary: basicSalary ?? salarySlipSummaryModel.basicSalary,
      totalBonuses: totalBonuses ?? salarySlipSummaryModel.totalBonuses,
      totalDeductions:
          totalDeductions ?? salarySlipSummaryModel.totalDeductions,
    );
    salarySlipSummaryModel.finalResult = getFinalResult;

    emit(salarySlipSummaryModel);
  }

  double get getFinalResult {
    double total = salarySlipSummaryModel.basicSalary! +
        salarySlipSummaryModel.totalBonuses! -
        salarySlipSummaryModel.totalDeductions!;
    return total;
  }

  void editCurrency(int id) {
    insertData(
        basicSalary: convertAmount(salarySlipSummaryModel.basicSalary!,
            salarySlipSummaryModel.currencyId!, id),
        totalBonuses: convertAmount(salarySlipSummaryModel.totalBonuses!,
            salarySlipSummaryModel.currencyId!, id),
        totalDeductions: convertAmount(salarySlipSummaryModel.totalDeductions!,
            salarySlipSummaryModel.currencyId!, id));
    salarySlipSummaryModel.currencyId = id;
    emit(salarySlipSummaryModel);
  }
}
