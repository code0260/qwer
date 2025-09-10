import 'package:almonazim/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class RefundRepo {
  Future<Either<Failure, void>> createFullBuyRefund(
      int invoicesId, String paymentState, bool? isShippingReturn);
  Future<Either<Failure, void>> createFullSellRefund(
      int invoiceId, String paymentState);
}
