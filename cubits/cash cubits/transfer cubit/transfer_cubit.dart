import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/cash%20repo/cash_repo_imp.dart';
import 'package:almonazim/data/model/cash%20models/transfer_model.dart';
import 'package:equatable/equatable.dart';

part 'transfer_state.dart';

class TransferCubit extends SafeCubit<TransferState> {
  TransferCubit(this.cashRepoImpl) : super(TransferInitial());
  CashRepoImpl cashRepoImpl;
  TransferModel transferModel = TransferModel();
  double conversion = 0;
  Future<void> transferCash() async {
    emit(TransferLoading());
    prepareBaseAmount();
    var result = await cashRepoImpl.transferCash(transferModel);
    result.fold((failure) {
      emit(TransferFailure(failure.errMessage));
    }, (_) {
      emit(const TransferSuccess());
    });
  }

  void assignData(
      {int? fromCurrencyId,
      int? toCurrencyId,
      double? feesAmount,
      double? feesAmountInBase,
      double? transferredAmountInFrom,
      double? transferredAmountInTo,
      double? conversionAmount}) {
    conversion = conversionAmount ?? conversion;
    transferModel = transferModel.copyWith(
      fromCurrencyId: fromCurrencyId ?? transferModel.fromCurrencyId,
      toCurrencyId: toCurrencyId ?? transferModel.toCurrencyId,
      feesAmount: feesAmount ?? transferModel.feesAmount,
      feesAmountInBase: feesAmountInBase ?? transferModel.feesAmountInBase,
      transferredAmountInFrom:
          transferredAmountInFrom ?? transferModel.transferredAmountInFrom,
      transferredAmountInTo:
          transferredAmountInTo ?? transferModel.transferredAmountInTo,
    );
    if (transferModel.fromCurrencyId != null &&
        transferModel.toCurrencyId != null &&
        transferModel.transferredAmountInFrom != null) {
      transferModel.transferredAmountInTo =
          transferModel.transferredAmountInFrom! * conversion;
    }
    emit(TransferDataChanged(transferModel: transferModel));
  }

  // fees
  void prepareBaseAmount() {
    if (transferModel.fromCurrencyId !=
            currencies
                .firstWhere(
                  (element) => element.businessCurrencyIsBase == 1,
                )
                .businessCurrencyId &&
        transferModel.feesAmount != 0) {
      transferModel.feesAmountInBase = convertAmountToBase(
          transferModel.feesAmount, transferModel.fromCurrencyId!);
    } else {
      transferModel.feesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (transferModel.fromCurrencyId == null) {
      return "الرجاء اختيار العملة المراد تحويلها";
    } else if (transferModel.toCurrencyId == null) {
      return "الرجاء اختيار العملة المراد التحويل إليها";
    } else if (transferModel.transferredAmountInFrom == null ||
        transferModel.transferredAmountInFrom == 0) {
      return "الرجاء إدخال المبلغ المراد تحويله";
    } else if (transferModel.transferredAmountInTo == null ||
        transferModel.transferredAmountInTo == 0) {
      return "الرجاء التحقق من معامل التحويل, يجب أن لا يكون صفراً";
    } else if (transferModel.fromCurrencyId == transferModel.toCurrencyId) {
      return 'الرجاء تعديل العملة';
    } else if (transferModel.transferredAmountInFrom! <
        transferModel.feesAmount) {
      return 'لا يمكن أن يكون الرسم أكبر من المبلغ';
    } else {
      return null;
    }
  }
}
