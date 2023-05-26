import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../Models/nft.dart';
import '../Models/nft_details.dart';

class ApiService {
  final Dio _dio;
  static ApiService? _instance;

  factory ApiService() {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal()
      : _dio = Dio(
          BaseOptions(
            receiveTimeout: const Duration(seconds: 30),
            connectTimeout: const Duration(seconds: 30),
          ),
        ) {
    _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true, request: true));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, _) async {
          if (e.type == DioErrorType.badResponse) {
            switch (e.response?.statusCode) {
              case 404:
                throw NotFoundException(e.response?.data ?? 'Not found');
              case 401:
                throw UnauthorizedException(e.response?.data ?? 'Unauthorized');
            }
          }
          throw e;
        },
      ),
    );
  }

  // Future<T> get<T>(UrlBuilder urlBuilder) async {
  //   const r = RetryOptions(maxAttempts: 3);
  //   Response response = await r.retry(
  //     () => _dio.get(
  //       urlBuilder.build(),
  //     ),
  //     retryIf: (e) => e is DioError && e.type == DioErrorType.connectionTimeout,
  //   );
  //   return _response<T>(response);
  // }

  Future<List<NfT>> getNFTs(UrlBuilder urlBuilder) async {
    const r = RetryOptions(maxAttempts: 3);
    Response response = await r.retry(
      () => _dio.get(
        urlBuilder.build(),
      ),
      retryIf: (e) => e is DioError && e.type == DioErrorType.connectionTimeout,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (response.data as List).map((e) => NfT.fromJson(e)).toList();
    } else {
      throw Exception(
          'Error occurred while communicating with server, status code: ${response.statusCode}');
    }
  }

  Future<NftDetails> getNFTDetails(UrlBuilder urlBuilder) async {
    const r = RetryOptions(maxAttempts: 3);

    Response response = await r.retry(
      () => _dio.get(
        urlBuilder.build(),
      ),
      retryIf: (e) => e is DioError && e.type == DioErrorType.connectionTimeout,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return NftDetails.fromJson(jsonDecode(response.data));
    } else {
      throw Exception(
          'Error occurred while communicating with server, status code: ${response.statusCode}');
    }
  }

  // Future<T> post<T>(UrlBuilder urlBuilder, Map<String, dynamic> data) async {
  //   const r = RetryOptions(maxAttempts: 3);
  //   Response response = await r.retry(
  //     () => _dio.post(urlBuilder.build(), data: data),
  //     retryIf: (e) => e is DioError && e.type == DioErrorType.connectionTimeout,
  //   );
  //   return _response(response);
  // }

  // T _response<T>(Response response) {
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return response.data;
  //   } else {
  //     throw Exception(
  //         'Error occurred while communicating with server, status code: ${response.statusCode}');
  //   }
  // }

  // // T _fromJson<T>(Map<String, dynamic> json) {
  // //   final obj = T a;
  // //   return obj.fromJson(json);
  // // }
}

class UrlBuilder {
  String? defaultBaseUrl;

  final String path;
  final Map<String, String>? queryParameters;

  UrlBuilder(
      {this.defaultBaseUrl = 'api.coingecko.com',
      required this.path,
      this.queryParameters});

  String build() {
    return Uri.https(defaultBaseUrl!, path, queryParameters).toString();
  }
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => 'UnauthorizedException: $message';
}
