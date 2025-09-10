import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StoreAccounts {
  static Future<List<AccountModel>> getAccounts() async {
    List<Map<String, Object?>> result =
        await DatabaseHelper.db.query("accounts");
    return result.map((e) => AccountModel.fromJson(e)).toList();
  }

  static Future<int> insertAccount(Map<String, dynamic> value) async {
    return DatabaseHelper.db.insert(
      "accounts",
      value,
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Optional: Handle duplicates
    );
  }

  static Future<int> deleteAllAccounts() async {
    return DatabaseHelper.db.delete("accounts");
  }
}
