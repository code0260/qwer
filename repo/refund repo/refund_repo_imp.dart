import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/refund%20repo/refund_repo.dart';
import 'package:dartz/dartz.dart';

class RefundRepoImpl implements RefundRepo {
  final ApiService apiService;
  RefundRepoImpl(this.apiService);
  @override
  Future<Either<Failure, void>> createFullBuyRefund(
      int invoiceId, String paymentState, bool? isShippingReturn) async {
    final result = await apiService.post(
        url: AppLinks.createFullBuyRefundLink,
        data: isShippingReturn == null
            ? {"invoices_id": invoiceId, 'payment_state': paymentState}
            : {
                "invoices_id": invoiceId,
                'payment_state': paymentState,
                'is_shipping_returned': isShippingReturn
              });

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> createFullSellRefund(
      int invoiceId, String paymentState) async {
    final result = await apiService.post(
        url: AppLinks.createFullSellRefundLink,
        data: {"invoices_id": invoiceId, 'payment_state': paymentState});

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
