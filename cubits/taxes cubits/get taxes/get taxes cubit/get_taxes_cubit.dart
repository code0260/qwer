import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/taxes%20repo/taxes_repo_imp.dart';
import 'package:almonazim/data/model/taxes%20models/taxes_model.dart';
import 'package:equatable/equatable.dart';

part 'get_taxes_state.dart';

class GetTaxesCubit extends SafeCubit<GetTaxesState> {
  GetTaxesCubit(this.taxRepo) : super(GetTaxesInitial());
  TaxesRepoImpl taxRepo;
  Future<void> getTaxes() async {
    emit(GetTaxesLoading());
    var result = await taxRepo.getTaxes();
    result.fold((failure) {
      emit(GetTaxesFailure(failure.errMessage));
    }, (taxes) {
      emit(GetTaxesSuccess(taxes: taxes));
    });
  }
}
