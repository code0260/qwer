import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:almonazim/core/device/device_utility.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/core/helper/functions/init_get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'api_consumer.dart';
import 'app_interceptors.dart';

class ApiService extends ApiConsumer {
  final Dio dio;

  ApiService({required this.dio}) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient client = HttpClient(); //! this code is not working on web
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    dio.options
      // ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false;
    dio.interceptors.add(getIt.get<AppInterceptors>());
    if (kDebugMode) {
      dio.interceptors.add(getIt.get<LogInterceptor>());
    }
  }
  @override
  Future<Either<Failure, dynamic>> get(
      {Map<String, dynamic>? queryParameters,
      required String url,
      Map<String, String>? headers}) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        final response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );

        handleIfCheckingRobot(response.data);

        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(
      {required String url,
      Object? data,
      ResponseType? responseType,
      bool formDataIsEnabled = true,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        final response = await dio.post(url,
            data: formDataIsEnabled
                ? FormData.fromMap(data as Map<String, dynamic>)
                : data,
            options: Options(headers: headers, responseType: responseType),
            queryParameters: queryParameters);

        handleIfCheckingRobot(response.data);

        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error, responseType: responseType));
    }
  }

  // Method for file upload
  @override
  Future<Either<Failure, dynamic>> uploadFile({
    required String url,
    required String filePath,
    required String requestName,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        File file = File(filePath);
        String fileName = file.path.split('/').last;
        FormData formData = FormData.fromMap({
          requestName:
              await MultipartFile.fromFile(filePath, filename: fileName),
          if (data != null) ...data, // Add extra data if provided
        });

        final response = await dio.post(
          url,
          data: formData,
          options: Options(
            headers: headers,
          ),
        );
        handleIfCheckingRobot(response.data);

        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  // Method for file upload
  @override
  Future<Either<Failure, dynamic>> uploadMultipleFiles({
    required String url,
    required List<String> filesPath,
    required List<String> requestNames,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        Map<String, dynamic> fromDataMap = {};
        for (var i = 0; i < filesPath.length; i++) {
          String filePath = filesPath[i];
          File file = File(filePath);
          String fileName = file.path.split('/').last;
          fromDataMap[requestNames[i]] =
              await MultipartFile.fromFile(filePath, filename: fileName);
        }
        if (data != null) {
          fromDataMap.addAll(data);
        }
        final response = await dio.post(
          url,
          data: FormData.fromMap(fromDataMap),
          options: Options(
            headers: headers,
          ),
        );
        handleIfCheckingRobot(response.data);

        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  @override
  Future<Either<Failure, dynamic>> delete(
      {Object? data,
      required String url,
      bool formDataIsEnabled = true,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        final response = await dio.delete(url,
            data: formDataIsEnabled
                ? FormData.fromMap(data as Map<String, dynamic>)
                : data,
            options: Options(
              headers: headers,
            ),
            queryParameters: queryParameters);
        handleIfCheckingRobot(response.data);
        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  @override
  Future<Either<Failure, dynamic>> put(
      {Object? data,
      required String url,
      Map<String, String>? headers,
      bool responseIsParsing = true,
      Map<String, dynamic>? queryParameters}) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        final response = await dio.put(
          url,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
        handleIfCheckingRobot(response.data);
        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  @override
  Future<Either<Failure, dynamic>> download(
      {Map<String, dynamic>? queryParameters,
      required String url,
      required String targetPath,
      Map<String, String>? headers}) async {
    try {
      if (await AppDevice.checkInternetFunction()) {
        final response = await dio.download(
          url,
          targetPath,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
        handleIfCheckingRobot(response.data);
        return right(response.data);
      } else {
        throw const SocketException("");
      }
    } catch (error) {
      return left(_handleError(error));
    }
  }

  ServerFailure _handleError(e, {ResponseType? responseType}) {
    if (e is HandshakeException || e is SocketException) {
      return ServerFailure("النت ضعيف الرجاء المحاولة عند الاتصال");
    }
    if (e is DioException) {
      if (responseType == ResponseType.bytes) {
        if (e.response == null) {
          return ServerFailure('حدث خطأ');
        }
        e.response!.data = jsonDecode(utf8.decode(e.response!.data));
      }
      return ServerFailure.fromDioError(e);
    }
    if (e is ServerFailure) {
      return e;
    }
    return ServerFailure(
      e.toString(),
    );
  }

  Null handleIfCheckingRobot(data) {
    if (data.toString().contains('Verifying that you are not a robot')) {
      return throw ServerFailure('تعذر الاتصال, الرجاء إطفاء ال VPN');
    } else {
      return null;
    }
  }
}
