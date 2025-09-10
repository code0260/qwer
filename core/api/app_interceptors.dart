import 'dart:io';

import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/constant/app_release_data.dart';
import 'package:almonazim/core/helper/functions/device%20functions/attach_device_info_to_headers.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_token.dart';
import 'package:almonazim/data/model/auth%20models/token_model.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors({
    required this.dio,
  });
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers['app-version'] = AppReleaseData.version;
    options.headers['app-type'] = AppReleaseData.appType;
    options.headers['device-data'] = await attachDeviceInfoToHeaders();
    getIt.get<TokenModel>().accessToken;
    if (getIt.get<TokenModel>().accessToken != null) {
      options.headers["authorization"] =
          "Bearer ${getIt.get<TokenModel>().accessToken}";
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401 &&
        (err.response!.data["message"] as String).contains("Expired token")) {
      if (getIt.get<TokenModel>().accessToken != null &&
          getIt.get<TokenModel>().refreshToken != null) {
        if (await refreshToken(getIt.get<TokenModel>())) {
          return handler.resolve(await _retry(err.requestOptions));
        }
      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final newData = requestOptions.data is FormData
        ? _cloneFormData(requestOptions.data as FormData)
        : requestOptions.data;

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      extra: requestOptions.extra,
      followRedirects: requestOptions.followRedirects,
      listFormat: requestOptions.listFormat,
      maxRedirects: requestOptions.maxRedirects,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      receiveTimeout: requestOptions.receiveTimeout,
      requestEncoder: requestOptions.requestEncoder,
      responseDecoder: requestOptions.responseDecoder,
      sendTimeout: requestOptions.sendTimeout,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: newData,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  FormData _cloneFormData(FormData original) {
    final newFormData = FormData();

    for (var field in original.fields) {
      newFormData.fields.add(MapEntry(field.key, field.value));
    }

    for (var file in original.files) {
      newFormData.files.add(MapEntry(
        file.key,
        file.value,
      ));
    }

    return newFormData;
  }

  Future<bool> refreshToken(TokenModel tokenModel) async {
    final response = await dio.post(
      AppLinks.refreshTokenLink,
      data: {
        "refresh_token": tokenModel.refreshToken,
        // "expires": tokenModel.expires
      },
    );
    if (response.statusCode == 200) {
      //token data
      tokenModel.accessToken = response.data["data"]["access_token"];
      tokenModel.refreshToken = response.data["data"]["refresh_token"];
      // tokenModel.expires = response.data["expires"];
      // logger.w(tokenModel.toString());
      await StoreToken.storeToken(tokenModel);
      await StoreToken.initTokenVariable();
      return true;
    } else {
      return false;
    }
  }
}
