import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';

abstract interface class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

final class NoParams {
  const NoParams();
}

const noParams = NoParams();
