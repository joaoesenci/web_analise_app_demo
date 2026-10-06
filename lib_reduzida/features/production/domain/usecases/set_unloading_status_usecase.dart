import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class SetUnloadingStatusParams {
  final int id;
  final String status;

  const SetUnloadingStatusParams(this.id, this.status);
}

final class SetUnloadingStatusUseCase
    implements UseCase<Unit, SetUnloadingStatusParams> {
  final IProductionRepository _repository;

  SetUnloadingStatusUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(SetUnloadingStatusParams params) async {
    return await _repository.setUnloadingStatus(params.id, params.status);
  }
}
