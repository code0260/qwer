import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/taxes%20repo/taxes_repo.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_input_model.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:dartz/dartz.dart';

class TaxesRepoImpl implements TaxesRepo {
  final ApiService apiService;
  TaxesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<TaxesModel>>> getTaxes() async {
    final result = await apiService.get(
      url: AppLinks.getTaxesLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<TaxesModel> taxesLocale = [];
        for (final tax in response["data"]) {
          taxesLocale.add(TaxesModel.fromJson(tax));
        }
        return right(taxesLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addTax(TaxesInputModel taxInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.addTaxesLink,
        data: taxInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importTaxes(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importTaxesLink,
        requestName: "taxes_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("16");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editTax(TaxesInputModel taxInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: false,
        url: AppLinks.editTaxesLink,
        data: taxInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
