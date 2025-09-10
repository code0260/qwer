import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/report%20models/top_dealing_model.dart';
import 'package:dartz/dartz.dart';

abstract class TopDealingRepo {
  Future<Either<Failure, List<TopDealingModel>>> getTopDealings(
      InvoiceType invoicesType);
}
