import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/deposit%20repo/deposit_repo.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_model.dart';
import 'package:equatable/equatable.dart';

part 'get_deposits_state.dart';

class GetDepositsCubit extends SafeCubit<GetDepositsState> {
  GetDepositsCubit(this.depositRepo) : super(GetDepositsInitial());
  DepositRepo depositRepo;
  DepositInputModel depositInputModel = DepositInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now());

  Future<void> getDeposits() async {
    emit(GetDepositsLoading());
    var result = await depositRepo.getDeposits(depositInputModel);
    result.fold((failure) {
      emit(GetDepositsFailure(failure.errMessage));
    }, (deposits) {
      emit(GetDepositsSuccess(deposits: deposits));
    });
  }
}
