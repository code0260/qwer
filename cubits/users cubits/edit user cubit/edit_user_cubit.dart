import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_user_state.dart';

class EditUserCubit extends SafeCubit<EditUserState> {
  EditUserCubit(this.userRepo) : super(EditUserInitial());
  UserRepoImpl userRepo;
  UserInputModel userInputModel = UserInputModel();

  Future<void> editUser() async {
    emit(EditUserLoading());
    var result = await userRepo.editUser(userInputModel);
    result.fold((failure) {
      emit(EditUserFailure(failure.errMessage));
    }, (_) {
      emit(const EditUserSuccess());
    });
  }
}
