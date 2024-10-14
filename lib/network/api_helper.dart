// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/error/exceptions.dart';
import '../core/utils/api_endpoints.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class APIHelper {
  Dio? _dio;

  static header() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };

  Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: APIEndpoints.APIBaseURL,
        headers: header(),
      ),
    );
    initInterceptors();
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  Future<Response> request({
    required String url,
    required Method method,
    params,
    String? loginToken,
  }) async {
    try {
      final response = await compute(_performHttpRequest, {
        'url': url,
        'method': method,
        'params': params,
        'LoginToken': loginToken,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw APIException(
          message: 'Unauthorized',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 500) {
        throw APIException(
          message: 'Server Error',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 422) {
        throw APIException(
          message: 'Unprocessable content',
          statusCode: response.statusCode!,
        );
      } else {
        throw APIException(
          message: 'Something went wrong',
          statusCode: response.statusCode!,
        );
      }
    } on SocketException catch (_) {
      throw const APIException(
        message: 'No Internet Connection',
        statusCode: 500,
      );
    } on FormatException catch (_) {
      throw const APIException(
        message: 'Bad response format',
        statusCode: 500,
      );
    } on DioException catch (e) {
      handleDioError(e);
      throw const APIException(
        message: 'Something went wrong',
        statusCode: 500,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw const APIException(
        message: 'Something went wrong',
        statusCode: 500,
      );
    }
  }

  static Future<Response> _performHttpRequest(Map<String, dynamic> data) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: APIEndpoints.APIBaseURL,
        headers: header(),
      ),
    );

    final url = data['url'];
    final method = data['method'];
    final params = data['params'];
    final loginToken = data['LoginToken'];

    try {
      Response response;

      switch (method) {
        case Method.POST:
          response = await dio.post(
            url,
            data: params,
            options: Options(headers: {"LoginToken": "$loginToken"}),
          );
          break;
        case Method.DELETE:
          response = await dio.delete(
            url,
            options: Options(headers: {"LoginToken": "$loginToken"}),
          );
          break;
        case Method.PATCH:
          response = await dio.patch(url);
          break;
        default:
          response = await dio.get(
            url,
            queryParameters: params,
            options: Options(headers: {"LoginToken": "$loginToken"}),
          );
          break;
      }

      return response;
    } on DioException catch (e) {
      handleDioError(e);
      throw Exception(e);
    }
  }

  static void handleDioError(DioException e) {
    if (e.type == DioExceptionType.unknown) {
      // logger.e("There is no internet connection");
    } else if (e.type == DioExceptionType.connectionError) {
      // logger.e("There is no internet connection");
    } else if (e.type == DioExceptionType.cancel) {
      // logger.e("Request to API server was cancelled");
    } else if (e.type == DioExceptionType.connectionTimeout) {
      // logger.e("Connection timeout with API server");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      // logger.e("Receive timeout in connection with API server");
    } else if (e.type == DioExceptionType.sendTimeout) {
      // logger.e("Send timeout in connection with API server");
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.statusCode == 401) {
        // logger.e("Your session is over, please sign in");
      } else {
        // logger.d(e.response);
        // logger.e(e.response?.data['message']);
      }
    }
  }
}
