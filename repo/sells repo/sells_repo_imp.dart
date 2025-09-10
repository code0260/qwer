import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/sells%20repo/sells_repo.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_input_model.dart';
import 'package:almonazim/data/model/sells%20models/sells_info_model.dart';
import 'package:dartz/dartz.dart';

class SellsRepoImpl implements SellsRepo {
  ApiService apiService;
  SellsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SellsInfoModel>> getSellsInfo(
      SellsInfoInputModel sellsInfoInputModel) async {
    final result = await apiService.post(
      url: AppLinks.getProductSellsLink,
      data: sellsInfoInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) => right(SellsInfoModel.fromJson(response["data"])),
    );
  }
}
