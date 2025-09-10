import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/profit%20report%20repo/profit_repo.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/invoice%20profit%20models/all_invoices_profit_model.dart';
import 'package:almonazim/data/model/profit%20report%20models/product%20profit%20models/get_product_profit_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfitRepoImpl implements ProfitRepo {
  final ApiService apiService;
  ProfitRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AllInvoicesProfitModel>> getInvoiceProfit(
      FilterModel filterModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.invoiceProfitLink,
        data: filterModel.toServer());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(AllInvoicesProfitModel.fromJson(response['data']));
      },
    );
  }

  @override
  Future<Either<Failure, List<int>>> getProductProfit(
      GetProductProfitModel getProductProfitModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        responseType: ResponseType.bytes,
        url: AppLinks.productProfitLink,
        data: getProductProfitModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) async {
        return right(response);
      },
    );
  }
}
