import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:equatable/equatable.dart';

part 'enter_demo_account_state.dart';

class EnterDemoAccountCubit extends SafeCubit<EnterDemoAccountState> {
  EnterDemoAccountCubit(this.userRepo) : super(EnterDemoAccountInitial());
  UserRepoImpl userRepo;
  UserInputModel userInputModel = UserInputModel();
  Future<void> enterDemoAccount() async {
    emit(EnterDemoAccountLoading());
    var result = await userRepo.enterDemoAccount(userInputModel);
    result.fold((failure) {
      emit(EnterDemoAccountFailure(errorMessage: failure.errMessage));
    }, (_) {
      emit(const EnterDemoAccountSuccess());
    });
  }
}
