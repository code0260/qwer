import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/custom dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/core/helper/functions/subtract_from_remaining.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/convert_count.dart';
import 'package:almonazim/data/data%20source/repo/unite%20repo/unite_repo_imp.dart';
import 'package:almonazim/data/model/cart%20models/sell_item_model.dart';
import 'package:almonazim/data/model/unit_model.dart';
import 'package:toastification/toastification.dart';

bool isBiggerThanRemaining(int productsId, double currentCount,
    double currentCountConversion, List<SellItemModel> items,
    {bool useAllExistedPlaces = false}) {
  for (final item in items) {
    if (item.getProductModel.productModel.productsId == productsId &&
        item.getProductModel.productModel.productsType ==
            ProductType.product.name) {
      double totalChosenCount = 0;
      int? totalChosenCountUnitId;
      for (final chosenPlace in item.chosenPlaceModels) {
        totalChosenCountUnitId ??=
            chosenPlace.productPlaceModel.productPlacesCountUnitId!;
        totalChosenCount += convertCount(
            chosenPlace.productPlaceModel.productPlacesCount!,
            totalChosenCountUnitId,
            chosenPlace.productPlaceModel.productPlacesCountUnitId!);
      }
      double remaining = subtractFromRemaining(
          currentCount,
          currentCountConversion,
          totalChosenCount,
          getIt
              .get<UnitRepoImpl>()
              .completeUnitModel(UnitModel(unitsId: totalChosenCountUnitId!))
              .unitsConversionFactor!);
      if (remaining >= 0) {
        return false;
      } else {
        if (useAllExistedPlaces) {
          var places = [];
          places.addAll(item.places);
          for (final e in item.chosenPlaceModels) {
            places.removeWhere((element) =>
                element.productPlaceModel.productPlacesId ==
                e.productPlaceModel.productPlacesId);
          }
          if (places.isNotEmpty) {
            item.chosenPlaceModels.add(places.first);
            isBiggerThanRemaining(
                productsId, currentCount, currentCountConversion, items);
          } else {
            mySnackBar(ToastificationType.error, "خطأ",
                "عذراً لم يتبقى ما يكفي من ${item.getProductModel.productModel.productsName} في هذا المكان");
            return true;
          }
        } else {
          mySnackBar(ToastificationType.error, "خطأ",
              "عذراً لم يتبقى ما يكفي من ${item.getProductModel.productModel.productsName} في هذا المكان");
          return true;
        }
      }
    }
  }
  return false;
}
