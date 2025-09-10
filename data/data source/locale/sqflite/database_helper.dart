import 'package:almonazim/core/constant/app_tables.dart';
import 'package:almonazim/core/constant/app_views.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static const databaseName = "accounting.db";
  static late final Database db;

  static Future<void> init() async {
    final databasePath = await getApplicationDocumentsDirectory();
    final path = "${databasePath.path}/$databaseName";
    db = await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON;");
        await db.execute('PRAGMA encoding = "UTF-8"');
      },
      onCreate: (db, version) async {
        //Tables
        await db.execute(AppTables.businessTbl);
        await db.execute(AppTables.productsTbl);
        await db.execute(AppTables.categoriesTbl);
        await db.execute(AppTables.pricesTbl);
        await db.execute(AppTables.unitsTbl);
        await db.execute(AppTables.placesTbl);
        await db.execute(AppTables.buildingsTbl);
        await db.execute(AppTables.clientsTbl);
        await db.execute(AppTables.partnersTbl);
        await db.execute(AppTables.batchesTable);
        await db.execute(AppTables.invoicesTbl);
        await db.execute(AppTables.debtsTbl);
        await db.execute(AppTables.sellItemTbl);
        await db.execute(AppTables.taxesTbl);
        await db.execute(AppTables.productTaxesTbl);
        await db.execute(AppTables.currenciesTbl);
        await db.execute(AppTables.businessCurrencyTbl);

        // Views
        await db.execute(AppViews.mySellProductsView);
        await db.execute(AppViews.myBuyProductsView);
        await db.execute(AppViews.buildingsWithPlacesView);
        await db.execute(AppViews.myBatchesView);
        await db.execute(AppViews.myInvoicesView);
        await db.execute(AppViews.sellItemView);
        await db.execute(AppViews.productTaxesView);
        await db.execute(AppViews.currencyView);
      },
    );
  }

  static Future<void> deleteAccountingDatabase() async {
    final databasePath = await getApplicationDocumentsDirectory();
    final path = "${databasePath.path}/$databaseName";
    await deleteDatabase(path);
  }

  static Future<void> clearDatabase() async {
    // Retrieve the list of all tables in the database
    final List<Map<String, dynamic>> tables = await db.rawQuery(
        'SELECT name FROM sqlite_master WHERE type = "table" AND name NOT LIKE "sqlite_%"');
    // Loop through the tables and delete all data
    for (final table in tables) {
      final tableName = table['name'];
      await db.rawQuery('DELETE FROM $tableName');
    }
  } // Insert operation

  static Future<Either<Failure, int>> insert(
      String table, Map<String, dynamic> values,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    try {
      var result = await db.insert(
        table,
        values,
        conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
      );
      return right(result);
    } catch (e) {
      logger.e(e.toString());
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Update operation
  static Future<Either<Failure, int>> update(
      String table, Map<String, dynamic> values,
      {String? where,
      List<dynamic>? whereArgs,
      ConflictAlgorithm? conflictAlgorithm}) async {
    try {
      var result = await db.update(table, values,
          where: where,
          whereArgs: whereArgs,
          conflictAlgorithm: conflictAlgorithm);
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  static Future<Either<Failure, int>> updateOrInsertData(
      String table, Map<String, dynamic> values) async {
    try {
      return await DatabaseHelper.db.transaction((txn) async {
        final result = await txn.query(table,
            where: "${table}_id = ? ", whereArgs: [values['${table}_id']]);
        int id = 0;
        if (result.isEmpty) {
          id = await txn.insert(table, values);
        } else {
          id = await txn.update(table, values,
              where: "${table}_id = ?", whereArgs: [values['${table}_id']]);
        }
        return right(id);
      });
    } catch (e) {
      print(e);
      if (e is LocalDatabaseFailure) {
        return left(LocalDatabaseFailure(e.errMessage));
      }
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

// Delete operation
  static Future<Either<Failure, int>> deleteViaIdList(String table,
      {required List<int> list}) async {
    try {
      var result = await db.delete(table,
          where:
              '${table}_id NOT IN (${("?," * list.length).substring(0, ("?," * list.length).length - 1)} )',
          whereArgs: list);
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Delete operation
  static Future<Either<Failure, int>> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    try {
      var result = await db.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

// Delete operation
  static Future<Either<Failure, void>> execute(String sql,
      {List<dynamic>? whereArgs}) async {
    try {
      var result = await db.execute(
        sql,
        whereArgs,
      );
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Query operation
  static Future<Either<Failure, List<Map<String, dynamic>>>> query(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    try {
      var result = await db.query(
        table,
        where: where,
        whereArgs: whereArgs,
      );
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Custom raw query operation (for complex queries)
  static Future<Either<Failure, List<Map<String, dynamic>>>> rawQuery(
      String sql,
      [List<dynamic>? arguments]) async {
    try {
      var result = await db.rawQuery(sql, arguments);
      return right(result);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
