import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/invoice%20profit%20models/all_invoices_profit_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/product%20profit%20models/get_product_profit_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfitRepo {
  Future<Either<Failure, AllInvoicesProfitModel>> getInvoiceProfit(
      FilterModel filterModel);
  Future<Either<Failure, List<int>>> getProductProfit(
      GetProductProfitModel getProductProfitModel);
}
