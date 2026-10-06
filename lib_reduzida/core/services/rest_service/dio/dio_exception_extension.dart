import 'package:dio/dio.dart';
import 'package:web_analise_app/core/domain/errors/exceptions.dart';

extension DioExceptionExtension on DioException {
  AppException toAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleBadResponse();

      default:
        return const UnknownException();
    }
  }

  AppException _handleBadResponse() {
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
      case 409:
      case 422:
        return ValidationException(message: response?.data['message']);

      case 401:
        return UnauthorizedException(
          title: response?.data['title'],
          message: response?.data['message'],
        );

      case 404:
        return NotFoundException(message: response?.data['message']);

      default:
        return ServerException(statusCode: statusCode);
    }
  }
}
