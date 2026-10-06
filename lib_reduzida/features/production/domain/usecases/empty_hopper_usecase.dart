import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class EmptyHopperParams {
  final int id;

  const EmptyHopperParams({required this.id});
}

final class EmptyHopperUseCase implements UseCase<Unit, EmptyHopperParams> {
  final IProductionRepository _repository;

  EmptyHopperUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(EmptyHopperParams params) async {
    return await _repository.emptyHopper(params.id);
  }
}
