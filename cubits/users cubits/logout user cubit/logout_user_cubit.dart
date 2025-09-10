import 'package:almonazim/core/helper/functions/auth%20functions/logout.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'logout_user_state.dart';

class LogoutUserCubit extends SafeCubit<LogoutUserState> {
  LogoutUserCubit(this.unitRepo) : super(LogoutUserInitial());
  UserRepoImpl unitRepo;
  Future<void> logoutUser() async {
    emit(LogoutUserLoading());
    var result = await unitRepo.logout();
    result.fold((failure) {
      emit(LogoutUserFailure(failure.errMessage));
    }, (units) async {
      await logout();
      emit(LogoutUserSuccess());
    });
  }
}
