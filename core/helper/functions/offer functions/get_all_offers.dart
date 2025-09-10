import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/offer%20repo/offer_repo_imp.dart';

Future<void> getAllOffers() async {
  var result = await getIt.get<OfferRepoImp>().getAllOffers();
  result.fold((l) {
    // mySnackBar(ToastificationType.error, "خطأ", l.errMessage);
  }, (r) => null);
}
