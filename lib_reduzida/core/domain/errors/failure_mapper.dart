import 'package:web_analise_app/core/domain/errors/exceptions.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';

Failure mapExceptionFailure(Object exception) {
  switch (exception) {
    case ServerException():
      return const ServerFailure();

    case NetworkException():
      return const NetworkFailure();

    case ValidationException():
      return ValidationFailure(
        message: exception.message ?? AppStrings.validationFailure,
      );

    case NotFoundException():
      return NotFoundFailure(
        message: exception.message ?? AppStrings.notfoundFailure,
      );

    case TimeoutException():
      return const TimeoutFailure();

    case UnauthorizedException():
      return UnauthorizedFailure(
        title: exception.title,
        message: exception.message ?? AppStrings.unauthorizedFailure,
      );

    case CacheException():
      return const CacheFailure();

    case ParseException():
      return const ParseFailure();

    default:
      return const UnknownFailure();
  }
}
