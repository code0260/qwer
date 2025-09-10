import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20repo/user_repo_imp.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_user_state.dart';

class AddUserCubit extends SafeCubit<AddUserState> {
  AddUserCubit(this.usersRepoImpl) : super(AddUserInitial());
  UserRepoImpl usersRepoImpl;
  UserInputModel userInputModel = UserInputModel(
      usersType: 'employee', usersCreatedAt: DateTime.now().toString());
  Future<void> addUser() async {
    emit(AddUserLoading());
    var result = await usersRepoImpl.addUser(userInputModel);
    result.fold((failure) {
      emit(AddUserFailure(failure.errMessage));
    }, (_) {
      emit(const AddUserSuccess());
    });
  }

  String? get validateDataMessage {
    if (userInputModel.usersPowers == null) {
      return "الرجاء اختيار الصلاحيات";
    } else if (userInputModel.usersEmail == null) {
      return "الرجاء إدخال البريد الإلكتروني";
    } else if (userInputModel.usersName == null ||
        userInputModel.usersName!.isEmpty) {
      return "الرجاء إدخال الاسم";
    } else if (userInputModel.usersPhone == null ||
        userInputModel.usersPhone!.isEmpty) {
      return "الرجاء إدخال رقم الهاتف";
    } else {
      return null;
    }
  }
}
