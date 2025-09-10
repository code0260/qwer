import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/database_helper.dart';
import 'package:almonazim/data/model/partner%20models/partner_model.dart';
import 'package:dartz/dartz.dart';

class StorePartners {
  StorePartners._();

  // Search for partners by name
  static Future<Either<Failure, List<PartnerModel>>> searchPartners(
      String query) async {
    final result = await DatabaseHelper.query(
      "partners",
      where: "partners_name LIKE ?",
      whereArgs: ['%$query%'], // Parameterized to avoid SQL injection
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<PartnerModel> searchResults =
            response.map((data) => PartnerModel.fromJson(data)).toList();
        return right(searchResults);
      },
    );
  }

  // Get all partners
  static Future<Either<Failure, List<PartnerModel>>> getAllPartners() async {
    final result = await DatabaseHelper.query("partners");

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<PartnerModel> partnersList =
            response.map((data) => PartnerModel.fromJson(data)).toList();
        return right(partnersList);
      },
    );
  }

  // Insert a new partner
  static Future<Either<Failure, int>> insertPartner(
      Map<String, dynamic> value) async {
    final result = await DatabaseHelper.insert("partners", value);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

// updatePartnerData
  static Future<Either<Failure, int>> updatePartnerData(
      Map<String, dynamic> partner) async {
    final result = await DatabaseHelper.updateOrInsertData("partners", partner);
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // Delete all partners
  static Future<Either<Failure, int>> deleteAllPartners() async {
    final result = await DatabaseHelper.delete("partners");
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  static Future<Either<Failure, int>> deletePartnersViaIdList(
      List<int> list) async {
    final result = await DatabaseHelper.deleteViaIdList("partners", list: list);
    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(response);
      },
    );
  }
}
