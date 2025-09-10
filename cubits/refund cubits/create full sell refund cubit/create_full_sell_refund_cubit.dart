import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/refund%20repo/refund_repo_imp.dart';

part 'create_full_sell_refund_state.dart';

class CreateFullSellRefundCubit extends SafeCubit<CreateFullSellRefundState> {
  CreateFullSellRefundCubit(this.refundRepImpl)
      : super(CreateFullSellRefundInitial());
  RefundRepoImpl refundRepImpl;
  Future<void> createFullSellRefund(int invoiceId, String paymentState) async {
    emit(CreateFullSellRefundLoading());
    var result =
        await refundRepImpl.createFullSellRefund(invoiceId, paymentState);
    result.fold((failure) {
      emit(CreateFullSellRefundFailure(failure.errMessage));
    }, (_) {
      emit(CreateFullSellRefundSuccess());
    });
  }
}
