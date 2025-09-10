import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/client%20models/client_model.dart';
import 'package:almonazim/data/model/user%20models/store_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StoreClients {
  StoreClients._();

  // Search for clients by name
  static Future<Either<Failure, List<ClientModel>>> searchClients(
      String query) async {
    final result = await DatabaseHelper.query(
      "clients",
      where: "clients_name LIKE ?",
      whereArgs: ['%$query%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ClientModel> searchResults =
            response.map((data) => ClientModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  static Future<Either<Failure, List<ClientModel>>> getOfflineClients() async {
    final result = await DatabaseHelper.query(
      "clients",
      where: "clients_online = ?",
      whereArgs: [0],
    );
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(
            response.map((data) => ClientModel.fromJson(data)).toList());
      },
    );
  }

  // Search for clients by name
  static Future<Either<Failure, ClientModel>> getClientById(int id) async {
    final result = await DatabaseHelper.query(
      "clients",
      where: "clients_id = ?",
      whereArgs: [id], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(ClientModel.fromJson(response[0]));
      },
    );
  }

  static Future<Either<Failure, void>> updateClientId(
      int oldId, int newId) async {
    var result = await DatabaseHelper.update(
      "clients",
      {"clients_id": newId, "clients_online": 1},
      where: "clients_id = ?",
      whereArgs: [oldId],
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }

  // Get all clients
  static Future<Either<Failure, List<ClientModel>>> getAllClients() async {
    final result = await DatabaseHelper.query("clients");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ClientModel> clientsList =
            response.map((data) => ClientModel.fromJson(data)).toList();
        return right(clientsList);
      },
    );
  }

  // Method to get all clients with type "customer" and merge with partners
  static Future<Either<Failure, List<ClientModel>>> getClientsAndPartners(
      String clientType) async {
    try {
      int businessId = StoreUserModel.instance.businessId!;
      return await DatabaseHelper.db.transaction((txn) async {
        // Query for clients of type "customer"
        final clientsResult = await txn.query(
          "clients",
          where: "clients_business_id = ? AND clients_type = ?",
          whereArgs: [businessId, clientType],
        );

        // Convert query results to ClientModel instances
        List<ClientModel> clientsList =
            clientsResult.map((data) => ClientModel.fromJson(data)).toList();

        // Query for partners associated with the given business ID
        final partnersResult = await txn.rawQuery('''
          SELECT partners.partners_name, partners.partners_id 
          FROM partners
          WHERE partners.partners_business_id = ?
        ''', [businessId]);

        // Convert partners data into ClientModel format and append to clients list
        for (var partner in partnersResult) {
          clientsList.add(
            ClientModel(
              clientsId: partner["partners_id"] as int?,
              clientsBusinessId: businessId,
              clientsName: "الشريك ${partner["partners_name"]}",
              clientsType: "partner",
            ),
          );
        }

        // Return the list of clients and partners
        return right(clientsList);
      });
    } catch (e) {
      // Handle and return failure if any error occurs during the transaction
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  // Get clients by ClientType (e.g., importer or customer)
  static Future<Either<Failure, List<ClientModel>>> getClients(
      String clientType) async {
    final result = await DatabaseHelper.query(
      "clients",
      where: "clients_type = ?",
      whereArgs: [clientType], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ClientModel> clientsList =
            response.map((data) => ClientModel.fromJson(data)).toList();
        return right(clientsList);
      },
    );
  }

  // Insert a new client
  static Future<Either<Failure, int>> insertClient(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("clients", value,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updateClientData
  static Future<Either<Failure, int>> updateClientData(
      Map<String, dynamic> client) async {
    final result = await DatabaseHelper.updateOrInsertData("clients", client);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all clients
  static Future<Either<Failure, int>> deleteAllClients() async {
    final result = await DatabaseHelper.delete("clients");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deleteClientsViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("clients", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
