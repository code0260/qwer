import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_edit_revenue_data.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_rent_prepaid_revenue_data.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_revenue_data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo.dart';
import 'package:almonazim/data/model/revenues%20models/get_revenues_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_categories_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_summary_model.dart';
import 'package:dartz/dartz.dart';

class RevenuesRepoImpl implements RevenuesRepo {
  final ApiService apiService;
  RevenuesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<RevenuesCategoriesModel>>>
      getRevenuesCategories() async {
    final result =
        await apiService.get(url: AppLinks.getRevenuesCategoriesLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<RevenuesCategoriesModel> revenuesCategories = [];
        for (final category in response["data"]) {
          revenuesCategories.add(RevenuesCategoriesModel.fromJson(category));
        }
        return right(revenuesCategories);
      },
    );
  }

  @override
  Future<Either<Failure, GetRevenuesModel>> getRevenues(
      RevenueInputModel revenuesInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getRevenuesLink,
        formDataIsEnabled: false,
        data: revenuesInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<RevenuesModel> revenues = [];
        for (final revenue in response["data"]) {
          revenues.add(RevenuesModel.fromJson(revenue));
        }
        GetRevenuesModel revenuesModel = GetRevenuesModel(
            revenues: revenues,
            revenuesSummaryModel: getRevenuesSummaryModel(revenues));
        return right(revenuesModel);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editRevenues(
      RevenueInputModel revenueInputModel, RevenuesModel revenuesModel) async {
    // print(prepareEditRevenueData(revenueInputModel));
    final result = await apiService.post(
        url: AppLinks.editRevenueLink,
        data: prepareEditRevenueData(revenueInputModel, revenuesModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  RevenuesSummaryModel getRevenuesSummaryModel(List<RevenuesModel> revenues) {
    double totalRevenues = 0;
    for (final revenue in revenues) {
      totalRevenues += revenue.revenuesAmountInBase ?? revenue.revenuesAmount!;
    }
    RevenuesSummaryModel revenuesSummaryModel = RevenuesSummaryModel(
        totalRevenues: totalRevenues,
        numberOfTransactions: revenues.length,
        averageTransactionAmount: totalRevenues / revenues.length);

    return revenuesSummaryModel;
  }

  @override
  Future<Either<Failure, void>> deleteRevenue(
      RevenueInputModel revenuesInputModel) async {
    final result = await apiService.delete(
        url: AppLinks.deleteRevenueLink,
        formDataIsEnabled: false,
        data: revenuesInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> addRevenue(
      RevenueInputModel revenueInputModel) async {
    // print(prepareRevenueData(revenueInputModel));
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addRevenueLink,
        data: prepareRevenueData(revenueInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> addRentPrepaidRevenue(
      RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addRentPrepaidRevenueLink,
        data: prepareRentPrepaidRevenueData(rentPrepaidRevenueInputModel));

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importRentPrepaidRevenues(
      String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importRentPrepaidRevenueLink,
        requestName: "rent_prepaid_revenues_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("10");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importRevenues(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importRevenueLink,
        requestName: "revenues_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("11");
        return right(null);
      },
    );
  }
}
