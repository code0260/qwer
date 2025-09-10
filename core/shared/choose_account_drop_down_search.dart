import 'package:almonazim/core/shared/custom_drop_down_search.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class ChooseAccountDropDownSearch extends StatelessWidget {
  const ChooseAccountDropDownSearch(
      {super.key,
      required this.accounts,
      this.defaultAccountId,
      this.title,
      required this.onGotId});
  final List<AccountModel> accounts;
  final int? defaultAccountId;
  final String? title;
  final void Function(int) onGotId;
  @override
  Widget build(BuildContext context) {
    return CustomDropDownSearch(
      title: title ?? "اختر حساب",
      data: List.generate(
          accounts.length, (index) => SelectedListItem(data: accounts[index])),
      selectedItems: (List<dynamic> selectedList) {
        SelectedListItem<dynamic> selectedListItem = selectedList[0];
        onGotId(selectedListItem.data.accountsId!.toInt());
      },
      selectedName: (p0) {
        var newVariable = p0.data as AccountModel;
        return newVariable.accountsName!;
      },
    );
  }
}
