import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/revenues%20repo/revenues_repo.dart';
import 'package:almonazim/data/model/revenues%20models/get_revenues_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:equatable/equatable.dart';

part 'get_revenues_state.dart';

class GetRevenuesCubit extends SafeCubit<GetRevenuesState> {
  GetRevenuesCubit(this.revenuesRepo) : super(GetRevenuesInitial());
  RevenuesRepo revenuesRepo;
  RevenueInputModel revenuesInputModel = RevenueInputModel(
    startDate: DateTime.now().subtract(const Duration(days: 1 * 30)),
    endDate: DateTime.now(),
  );

  Future<void> getRevenues() async {
    emit(GetRevenuesLoading());
    var result = await revenuesRepo.getRevenues(revenuesInputModel);
    result.fold((failure) {
      emit(GetRevenuesFailure(failure.errMessage));
    }, (revenuesModel) {
      emit(GetRevenuesSuccess(getRevenuesModel: revenuesModel));
    });
  }
}
