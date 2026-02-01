import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core.dart';

abstract class HttpClientService {
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
  Future<Response> fetch({required RequestOptions requestOptions});
  Future<Response> post({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
  Future<Response> put({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
  Future<Response> patch({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
  Future<Response> delete({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}

@Named('openWeatherAPI')
@LazySingleton(as: HttpClientService)
class HttpClientServiceImpl implements HttpClientService {
  final Dio dio;
  final InternetConnectionService internetConnectionService;
  final LoggerService loggerService;

  HttpClientServiceImpl({
    @Named('openWeatherAPI') required this.dio,
    required this.internetConnectionService,
    required this.loggerService,
  }) : super() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Future<Response> delete({
    required String path,
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.delete<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.get<String>(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }

  @override
  Future<Response> fetch({required RequestOptions requestOptions}) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.fetch(requestOptions);

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }

  @override
  Future<Response> patch({
    required String path,
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.patch<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String path,
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.post<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }

  @override
  Future<Response> put({
    required String path,
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await internetConnectionService.hasConnection;

      final response = await dio.put<String>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on ConnectionException catch (e, trace) {
      loggerService.error('Connection error', e, trace);
      rethrow;
    } on DioException catch (e, trace) {
      loggerService.error('HTTP error', e, trace);
      rethrow;
    }
  }
}
