import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/product%20repos/top%20dealing%20repo/top_dealing_repo_imp.dart';
import 'package:almonazim/data/model/report%20models/top_dealing_model.dart';
import 'package:equatable/equatable.dart';

part 'get_top_dealing_state.dart';

class GetTopDealingCubit extends SafeCubit<GetTopDealingState> {
  GetTopDealingCubit(this.topDealingRepo) : super(GetTopDealingInitial());
  TopDealingRepoImpl topDealingRepo;
  Future<void> getTopDealing(InvoiceType invoiceType) async {
    emit(GetTopDealingLoading());
    var result = await topDealingRepo.getTopDealings(invoiceType);
    result.fold((failure) {
      emit(GetTopDealingFailure(failure.errMessage));
    }, (topDealings) {
      emit(GetTopDealingSuccess(tops: topDealings));
    });
  }
}
