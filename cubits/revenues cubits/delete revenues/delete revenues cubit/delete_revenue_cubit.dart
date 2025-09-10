import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo_imp.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_revenue_state.dart';

class DeleteRevenueCubit extends SafeCubit<DeleteRevenueState> {
  DeleteRevenueCubit(this.revenueRepo) : super(DeleteRevenueInitial());
  RevenuesRepoImpl revenueRepo;
  Future<void> deleteRevenue(RevenueInputModel revenueInputModel) async {
    emit(DeleteRevenueLoading());
    var result = await revenueRepo.deleteRevenue(revenueInputModel);
    result.fold((failure) {
      emit(DeleteRevenueFailure(errorMessage: failure.errMessage));
    }, (message) {
      emit(DeleteRevenueSuccess());
    });
  }
}
