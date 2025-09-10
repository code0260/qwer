import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends SafeCubit<EditAccountState> {
  EditAccountCubit(this.accountRepo) : super(EditAccountInitial());
  AccountRepoImpl accountRepo;
  AccountInputModel accountInputModel = AccountInputModel();
  Future<void> editAccount() async {
    emit(EditAccountLoading());
    var result = await accountRepo.editAccount(accountInputModel);
    result.fold((failure) {
      emit(EditAccountFailure(failure.errMessage));
    }, (_) {
      emit(const EditAccountSuccess());
    });
  }

  String? get validateDataMessage {
    if (accountInputModel.accountsName?.isEmpty ?? true) {
      return "الرجاء إدخال اسم الحساب";
    } else if (accountInputModel.accountsIsSub == null) {
      return "الرجاء تحديد نوع الحساب";
    } else if (accountInputModel.accountsParentId == null &&
        accountInputModel.accountsLevel! > 1) {
      return "يجب تحديد حساب الأب للحسابات الفرعية";
    } else if (accountInputModel.accountsCode?.isEmpty ?? true) {
      return "الرجاء إدخال رمز الحساب";
    } else {
      return null;
    }
  }
}
