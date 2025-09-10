import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/product%20report%20repos/product%20account%20statment%20repo/product_statement_repo.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_input_model.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_model.dart';
import 'package:dartz/dartz.dart';

class ProductStatementRepoImpl implements ProductStatementRepo {
  final ApiService apiService;
  ProductStatementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ProductStatementModel>> getProductStatements(
      ProductStatementInputModel productStatementInputModel) async {
    final result = await apiService.post(
      url: AppLinks.productStatementLink,
      formDataIsEnabled: false,
      data: productStatementInputModel.toMap(),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(ProductStatementModel.fromJson(response["data"]));
      },
    );
  }
}
