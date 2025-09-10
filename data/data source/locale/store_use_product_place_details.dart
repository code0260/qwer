import 'package:almonazim/core/helper/pref_storage.dart';

class StoreUseProductPlaceDetails {
  StoreUseProductPlaceDetails._();
  static Future<void> setUseProductPlaceDetails(
      bool useProductPlaceDetails) async {
    await PrefStorage.setBool("useProductPlaceDetails", useProductPlaceDetails);
  }

  static bool? getUseProductPlaceDetails() {
    bool? useProductPlaceDetails =
        PrefStorage.getBool('useProductPlaceDetails');
    return useProductPlaceDetails;
  }
}
