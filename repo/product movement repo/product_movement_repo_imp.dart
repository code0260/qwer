import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/product%20movement%20repo/product_movement_repo.dart';
import 'package:almonazim/data/model/product%20movement/move_product_model.dart';
import 'package:dartz/dartz.dart';

class ProductMovementRepoImpl implements ProductMovementRepo {
  final ApiService apiService;
  ProductMovementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> moveProduct(
      MoveProductModel moveProductModel) async {
    // print(moveProductModel.toMap());
    final result = await apiService.post(
        url: AppLinks.moveProductLink,
        formDataIsEnabled: false,
        data: moveProductModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
    // return right(null);
  }
}
