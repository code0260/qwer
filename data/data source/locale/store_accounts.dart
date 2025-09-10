import 'dart:convert';

import 'package:almonazim/core/helper/functions/account%20functions/prepare_tree_node.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_expense_tree_node.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_revenue_tree_node.dart';
import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';

class StoreAccounts {
  StoreAccounts._();
  static Future<void> setAccounts(dynamic accounts) async {
    await PrefStorage.remove('accounts');
    await PrefStorage.set("accounts", jsonEncode(accounts));
  }

  static TreeNode? getChartOfExpenses() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      TreeNode treeNode = TreeNode.root();
      prepareExpenseTreeNode(jsonDecode(jsonString), treeNode);
      return treeNode;
    }
    return null;
  }

  static List<AccountModel>? getExpenseAccountsModels() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      List<AccountModel> accounts = [];
      for (final account in list) {
        if ((account["accounts_code"] as String).startsWith("3") &&
            account["accounts_is_sub"] == 1) {
          accounts.add(AccountModel.fromJson(account));
        }
      }
      return accounts;
    }
    return null;
  }

  static TreeNode? getChartOfAccounts() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      TreeNode treeNode = TreeNode.root();
      prepareTreeNode(jsonDecode(jsonString), treeNode);
      return treeNode;
    }
    return null;
  }

  static List<dynamic>? getAccountsMap() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static List<AccountModel>? getAccountsModels() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      List<AccountModel> accounts = [];
      for (final account in list) {
        accounts.add(AccountModel.fromJson(account));
      }
      return accounts;
    }
    return null;
  }

  static List<AccountModel>? getAccountsStartWithCode(String code) {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      List<AccountModel> accounts = [];
      for (final account in list) {
        if ((account["accounts_code"] as String).startsWith(code) &&
            account["accounts_is_sub"] == 1) {
          accounts.add(AccountModel.fromJson(account));
        }
      }
      return accounts;
    }
    return null;
  }

  static AccountModel? getAccountByCode(String code) {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      AccountModel accountModel = const AccountModel();
      for (final account in list) {
        if (account["accounts_code"] == code) {
          accountModel = AccountModel.fromJson(account);
          break;
        }
      }
      return accountModel;
    }
    return null;
  }

  static AccountModel? getAccountsById(int id) {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      AccountModel? accountModel;
      for (final account in list) {
        if (account["accounts_id"] == id) {
          accountModel = AccountModel.fromJson(account);
          break;
        }
      }
      return accountModel;
    }
    return null;
  }

  static List<AccountModel>? getAccountsByName(String name) {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      List<AccountModel> accounts = [];
      for (final account in list) {
        if (account["accounts_name"] == name) {
          accounts.add(AccountModel.fromJson(account));
        }
      }
      return accounts;
    }
    return null;
  }

  //$ revenue
  static TreeNode? getChartOfRevenues() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      TreeNode treeNode = TreeNode.root();
      prepareRevenueTreeNode(jsonDecode(jsonString), treeNode);
      return treeNode;
    }
    return null;
  }

  static List<AccountModel>? getRevenueAccountsModels() {
    String? jsonString = PrefStorage.get('accounts');
    if (jsonString != null) {
      List<dynamic> list = jsonDecode(jsonString);
      List<AccountModel> accounts = [];
      for (final account in list) {
        if ((account["accounts_code"] as String).startsWith("4") &&
            account["accounts_is_sub"] == 1) {
          accounts.add(AccountModel.fromJson(account));
        }
      }
      return accounts;
    }
    return null;
  }
}
