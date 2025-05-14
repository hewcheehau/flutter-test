import 'package:dio/dio.dart';

typedef Jmap = Map<String, dynamic>;

class DioClient {
  DioClient({required this.baseUrl, this.headers, this.interceptors, this.sendTimeout = 30, this.receiveTimeout = 30, this.connectTimeout = 30});

  final String baseUrl;
  final Jmap? headers;
  final List<Interceptor>? interceptors;
  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;

  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: Duration(seconds: connectTimeout),
        receiveTimeout: Duration(seconds: receiveTimeout),
        sendTimeout: Duration(seconds: sendTimeout),
      ),
    );

    if (interceptors != null) {
      dio.interceptors.addAll(interceptors!);
    }

    return dio;
  }

  Future<Response> get(String path, {Jmap? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    return await dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Jmap? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
