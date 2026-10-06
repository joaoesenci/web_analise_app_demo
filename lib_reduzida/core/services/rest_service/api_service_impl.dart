import 'package:dio/dio.dart';
import 'package:web_analise_app/core/services/network/api/api_service.dart';

final class ApiServiceImpl implements IApiService {
  final Dio dio;

  ApiServiceImpl(this.dio);

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<dynamic>> path(String path, {dynamic, data}) async {
    return await dio.patch(path, data: data);
  }

  @override
  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  @override
  Future<Response> delete(String path, {dynamic data}) async {
    return await dio.delete(path, data: data);
  }
}
