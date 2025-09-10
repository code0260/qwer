import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/partner%20functions/prepare_add_partner_transaction.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/partners%20repo/partner_repo.dart';
import 'package:almonazim/data/model/partner%20models/add_partner_model.dart';
import 'package:almonazim/data/model/partner%20models/partner_input_model.dart';
import 'package:almonazim/data/model/partner%20models/partner_model.dart';
import 'package:dartz/dartz.dart';

class PartnerRepoImpl implements PartnerRepo {
  final ApiService apiService;
  PartnerRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PartnerModel>>> getPartners() async {
    final result = await apiService.get(url: AppLinks.getPartnersLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<PartnerModel> partnersLocale = [];
        for (final partner in response["data"]) {
          partnersLocale.add(PartnerModel.fromJson(partner));
        }
        return right(partnersLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> editPartner(
      PartnerInputModel partnerInputModel) async {
    // print(partnerInputModel.toMap());
    final result = await apiService.post(
        url: AppLinks.editPartnerLink,
        data: partnerInputModel.toMap(),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }

  @override
  Future<Either<Failure, void>> addPartner(
      AddPartnerModel addPartnerModel) async {
    // print(prepareAddPartnerTransaction(addPartnerModel));
    final result = await apiService.post(
        url: AppLinks.addPartnerLink,
        data: prepareAddPartnerTransaction(addPartnerModel),
        formDataIsEnabled: false);

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return left(ServerFailure('test'));
  }

  @override
  Future<Either<Failure, void>> importUsers(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importUsersLink,
        requestName: "users_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("18");
        return right(null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> importPartners(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importPartnersLink,
        requestName: "partners_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("19");
        return right(null);
      },
    );
  }
}
