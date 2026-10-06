import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/entities/weighing_entity.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class SaveWeightParams {
  final int id;
  final WeighingEntity weighing;

  const SaveWeightParams({required this.id, required this.weighing});
}

final class SaveWeightUseCase implements UseCase<Unit, SaveWeightParams> {
  final IProductionRepository _repository;

  SaveWeightUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(SaveWeightParams params) async {
    return await _repository.saveWeight(params.id, params.weighing);
  }
}
