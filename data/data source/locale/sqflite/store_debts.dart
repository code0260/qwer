import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:dartz/dartz.dart';

class StoreDebts {
  StoreDebts._();

  // Search for debts by person name or other criteria
  static Future<Either<Failure, DebtModel>> getDebtByInvoice(
      int invoiceId) async {
    final result = await DatabaseHelper.query(
      "debts",
      where: "debts_invoices_id = ?", // Search by person name
      whereArgs: ['%$invoiceId%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(DebtModel.fromJson(response[0]));
      },
    );
  }

  // Get all debts
  static Future<Either<Failure, List<DebtModel>>> getDebts() async {
    final result = await DatabaseHelper.query("debts");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<DebtModel> gotResults =
            response.map((data) => DebtModel.fromJson(data)).toList();
        return right(gotResults);
      },
    );
  }

  // Get all debts
  static Future<Either<Failure, double>> getTotalClientDebt(
      int clientsId) async {
    final result = await DatabaseHelper.rawQuery('''
    SELECT 
      SUM(
        IFNULL(debts_total_amount_in_base, debts_total_amount) -
        IFNULL(debts_paid_amount_in_base, debts_paid_amount)
      ) AS total_debt
    FROM debts
    WHERE debts_clients_id = ?
  ''', [clientsId]);

    return result.fold(
      (failure) => left(failure),
      (response) {
        if (response[0].isEmpty || response[0]['total_debt'] == null) {
          return right(0);
        } else {
          return right(response[0]['total_debt']);
        }
      },
    );
  }

  // Insert a new debt
  static Future<Either<Failure, int>> insertDebt(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("debts", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all debts
  static Future<Either<Failure, int>> deleteAllDebts() async {
    final result = await DatabaseHelper.delete("debts");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }
}
