import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/accounts%20repo/account_repo_imp.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:equatable/equatable.dart';

part 'add_account_state.dart';

class AddAccountCubit extends SafeCubit<AddAccountState> {
  AddAccountCubit(this.accountRepo) : super(AddAccountInitial());
  AccountRepoImpl accountRepo;
  AccountInputModel accountInputModel = AccountInputModel();
  Future<void> addAccount() async {
    emit(AddAccountLoading());
    var result = await accountRepo.addAccount(accountInputModel);
    result.fold((failure) {
      emit(AddAccountFailure(failure.errMessage));
    }, (_) {
      emit(const AddAccountSuccess());
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

  void setDefaultValues(TreeNode treeNode) {
    AccountModel? accountModel = treeNode.data;
    accountInputModel.accountsParentId = accountModel!.accountsId;
    accountInputModel.accountsLevel = accountModel.accountsLevel! + 1;
    accountInputModel.accountsNature = accountModel.accountsNature;
    accountInputModel.accountsStatement = accountModel.accountsStatement;
    accountInputModel.accountParentPrepaidExpenseName =
        accountModel.accountsName!;
    if (treeNode.children.isNotEmpty) {
      accountInputModel.accountsCode =
          (treeNode.children.entries.last.key.toInt() + 1).toString();
    } else {
      accountInputModel.accountsCode = accountModel.accountsCode;
    }
  }
}
