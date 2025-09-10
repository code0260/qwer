import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/refund%20repo/refund_repo_imp.dart';

part 'create_full_buy_refund_state.dart';

class CreateFullBuyRefundCubit extends SafeCubit<CreateFullBuyRefundState> {
  CreateFullBuyRefundCubit(this.refundRepImpl)
      : super(CreateFullBuyRefundInitial());
  RefundRepoImpl refundRepImpl;
  Future<void> createFullBuyRefund(
      int invoiceId, String paymentState, bool? isShippingReturned) async {
    emit(CreateFullBuyRefundLoading());
    var result = await refundRepImpl.createFullBuyRefund(
        invoiceId, paymentState, isShippingReturned);
    result.fold((failure) {
      emit(CreateFullBuyRefundFailure(failure.errMessage));
    }, (_) {
      emit(CreateFullBuyRefundSuccess());
    });
  }
}
