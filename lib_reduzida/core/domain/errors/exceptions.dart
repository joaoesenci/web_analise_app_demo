sealed class AppException implements Exception {
  final String? message;

  const AppException({this.message});
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({super.message, this.statusCode});
}

class NetworkException extends AppException {
  const NetworkException({super.message});
}

class ValidationException extends AppException {
  const ValidationException({super.message});
}

class NotFoundException extends AppException {
  const NotFoundException({super.message});
}

class TimeoutException extends AppException {
  const TimeoutException({super.message});
}

class UnauthorizedException extends AppException {
  final String? title;

  const UnauthorizedException({super.message, this.title});
}

class ParseException extends AppException {
  const ParseException({super.message});
}

class CacheException extends AppException {
  const CacheException({super.message});
}

class UnknownException extends AppException {
  const UnknownException({super.message});
}
