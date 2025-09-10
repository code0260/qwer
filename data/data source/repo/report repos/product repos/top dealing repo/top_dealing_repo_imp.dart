import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/product%20repos/top%20dealing%20repo/top_dealing_repo.dart';
import 'package:almonazim/data/model/report%20models/top_dealing_model.dart';
import 'package:dartz/dartz.dart';

class TopDealingRepoImpl implements TopDealingRepo {
  final ApiService apiService;
  TopDealingRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<TopDealingModel>>> getTopDealings(
      InvoiceType invoiceType) async {
    final result = await apiService.post(
      url: AppLinks.getTopDealingLink,
      data: {
        "invoices_type": invoiceType.name,
      },
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TopDealingModel> topLocale = [];
        for (final top in response["data"]) {
          topLocale.add(TopDealingModel.fromJson(top));
        }
        return right(topLocale);
      },
    );
  }
}
