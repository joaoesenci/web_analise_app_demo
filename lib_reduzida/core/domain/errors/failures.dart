import 'package:web_analise_app/core/services/network/api/api_error_titles.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';

abstract class Failure {
  final String? message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = AppStrings.serverFailure});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = AppStrings.networkFailure});
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = AppStrings.timeoutFailure});
}

class UnauthorizedFailure extends Failure {
  final String? title;

  const UnauthorizedFailure({super.message, this.title});

  bool get requiresLogout {
    return [
      ApiErrorTitles.sessionExpired,
      ApiErrorTitles.httpUnauthorizedError,
    ].contains(title);
  }
}

class ParseFailure extends Failure {
  const ParseFailure({super.message = AppStrings.parseFailure});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = AppStrings.cacheFailure});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = AppStrings.unknownFailure});
}
