import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/bought%20repo/bought_repo.dart';
import 'package:almonazim/data/model/bought%20models/bought_info_input_model.dart';
import 'package:almonazim/data/model/bought%20models/bought_info_model.dart';
import 'package:dartz/dartz.dart';

class BoughtRepoImpl implements BoughtRepo {
  final ApiService apiService;
  BoughtRepoImpl(this.apiService);

  @override
  Future<Either<Failure, BoughtInfoModel>> getBoughtInfo(
      BoughtInfoInputModel boughtInfoInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getProductBoughtLink, data: boughtInfoInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) => right(BoughtInfoModel.fromJson(response["data"])),
    );
  }
}
