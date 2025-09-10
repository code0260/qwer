abstract class ApiConsumer {
  Future<dynamic> get(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers});

  Future<dynamic> post(
      {Object? data,
      required String url,
      bool formDataIsEnabled = true,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers});
  Future<dynamic> uploadFile({
    required String url,
    required String filePath,
    required String requestName,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  });
  Future<dynamic> delete(
      {Object? data,
      required String url,
      bool formDataIsEnabled = true,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers});

  Future<dynamic> put(
      {Object? data,
      required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers});

  Future<dynamic> download(
      {Map<String, dynamic>? queryParameters,
      required String url,
      required String targetPath,
      Map<String, String>? headers});

  Future<dynamic> uploadMultipleFiles({
    required String url,
    required List<String> filesPath,
    required List<String> requestNames,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  });
}
