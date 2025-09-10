import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_units.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';

Future<int?> syncOfflineUnits() async {
  // Fetch all offline units
  var result = await StoreUnits.getOfflineUnits();
  return result.fold(
    (failure) => throw Exception(failure.errMessage),
    (offlineUnits) async {
      if (offlineUnits.isNotEmpty) {
        // Convert offline units to input models

        // Send units to the server
        var response =
            await getIt.get<UnitRepoImpl>().addMultipleUnits(offlineUnits);

        return response.fold(
          (failure) =>
              throw Exception("فشل في مزامنة الواحدات: ${failure.errMessage}"),
          (idMap) async {
            // Update local database with new IDs
            for (var unitModel in offlineUnits) {
              int originalId = unitModel.unitsId!;
              String? newId = idMap["$originalId"];
              if (newId != null) {
                await StoreUnits.updateUnitId(originalId, newId.toInt());
              }
            }
            return 1;
          },
        );
      }
      return null;
    },
  );
}
