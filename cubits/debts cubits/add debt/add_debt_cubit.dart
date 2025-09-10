import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/debts%20repo/debts_repo.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_debt_state.dart';

class AddDebtCubit extends SafeCubit<AddDebtState> {
  AddDebtCubit(this.debtsRepo) : super(AddDebtInitial());
  DebtsRepo debtsRepo;
  DebtInputModel debtInputModel = DebtInputModel(debtsPaidAmount: 0);
  Future<void> addDebt() async {
    prepareSendDebt();
    emit(AddDebtLoading());
    var result = await debtsRepo.addDebt(debtInputModel);
    result.fold((failure) {
      emit(AddDebtFailure(failure.errMessage));
    }, (_) {
      emit(AddDebtSuccess());
    });
  }

  void prepareSendDebt() {
    var baseCurrency = currencies.firstWhere(
      (element) => element.businessCurrencyIsBase == 1,
    );
    debtInputModel.debtsAmountCurrencyId ??= baseCurrency.businessCurrencyId;

    if (debtInputModel.debtsAmountCurrencyId !=
        baseCurrency.businessCurrencyId) {
      debtInputModel.debtsTotalAmountInBase = convertAmountToBase(
          debtInputModel.debtsTotalAmount!,
          debtInputModel.debtsAmountCurrencyId!);
      if (debtInputModel.debtsPaidAmount != 0 ||
          debtInputModel.debtsPaidAmountInBase != null) {
        debtInputModel.debtsPaidAmountInBase = convertAmountToBase(
            debtInputModel.debtsPaidAmountInBase!,
            debtInputModel.debtsAmountCurrencyId!);
      }
    } else {
      debtInputModel.debtsTotalAmountInBase = null;
      debtInputModel.debtsPaidAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (debtInputModel.debtsState == null) {
      return "الرجاء إدخال حالة الدفع";
    } else if (debtInputModel.debtsTotalAmount == null ||
        debtInputModel.debtsTotalAmount == 0) {
      return "الرجاء إدخال المبلغ الكلي";
    } else if (debtInputModel.debtsState == "partial" &&
        debtInputModel.debtsPaidAmount == 0) {
      return "الرجاء إدخال المبلغ المدفوع";
    } else if (debtInputModel.debtsEmployeesId == null &&
        debtInputModel.debtsClientsId == null &&
        (debtInputModel.debtsPersonName == null ||
            debtInputModel.debtsPersonName == "")) {
      return "الرجاء إدخال اسم الشخص أو العميل";
    } else if (debtInputModel.debtsEmployeesId == null &&
        debtInputModel.debtsClientsId == null &&
        debtInputModel.debtsPersonNameType == null) {
      return "الرجاء إدخال طبيعة الدين";
    } else if (debtInputModel.debtsPersonName == null &&
        debtInputModel.debtsPersonNameType == null &&
        debtInputModel.debtsClientsId == null &&
        debtInputModel.debtsEmployeesId == null) {
      return "الرجاء اختيار النوع وإضافة المعلومات";
    } else {
      return null;
    }
  }
}
