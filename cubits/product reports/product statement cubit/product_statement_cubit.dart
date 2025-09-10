import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/product%20report%20repos/product%20account%20statment%20repo/product_statement_repo.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_input_model.dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_model.dart';
import 'package:equatable/equatable.dart';

part 'product_statement_state.dart';

class ProductStatementCubit extends SafeCubit<ProductStatementState> {
  ProductStatementCubit(this.cashRepo) : super(ProductStatementInitial());
  ProductStatementRepo cashRepo;
  ProductStatementInputModel productStatementInputModel =
      ProductStatementInputModel(
          startDate: DateTime.now().subtract(const Duration(days: 7)),
          endDate: DateTime.now());
  Future<void> getProductStatement() async {
    emit(ProductStatementLoading());
    var result =
        await cashRepo.getProductStatements(productStatementInputModel);
    result.fold((failure) {
      emit(ProductStatementFailure(failure.errMessage));
    }, (model) {
      emit(ProductStatementSuccess(statementModel: model));
    });
  }
}
