import 'package:dio/dio.dart';

abstract interface class IApiService {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> path(String path, {dynamic, data});

  Future<Response> put(String path, {dynamic data});

  Future<Response> delete(String path, {dynamic data});
}
