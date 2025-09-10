import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data/model/auth%20models/token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreToken {
  StoreToken._();
  static Future<void> storeToken(TokenModel tokenModel) async {
    // await getIt
    //     .get<FlutterSecureStorage>().deleteAll();
    await getIt
        .get<FlutterSecureStorage>()
        .write(key: "access-token", value: tokenModel.accessToken);
    await getIt
        .get<FlutterSecureStorage>()
        .write(key: "refresh-token", value: tokenModel.refreshToken);
    await getIt.get<FlutterSecureStorage>().write(
        key: "expires", value: tokenModel.expires); // can be null normally
  }

  static Future<TokenModel> initTokenVariable() async {
    getIt.get<TokenModel>().accessToken =
        await getIt.get<FlutterSecureStorage>().read(key: "access-token");
    getIt.get<TokenModel>().refreshToken =
        await getIt.get<FlutterSecureStorage>().read(key: "refresh-token");
    getIt.get<TokenModel>().expires =
        await getIt.get<FlutterSecureStorage>().read(key: "expires");
    return getIt.get<TokenModel>();
  }
}
