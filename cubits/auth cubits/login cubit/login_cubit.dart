import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/auth%20repo/auth_repo.dart';
// import 'package:almonazim/data/model/user%20models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends SafeCubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  AuthRepo authRepo;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    var result = await authRepo.login(email, password);
    result.fold((failure) {
      emit(LoginFailure(failure.errMessage));
    }, (_) async {
      emit(const LoginSuccess());
    });
  }
}
