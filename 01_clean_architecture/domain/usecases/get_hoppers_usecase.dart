import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class GetHoppersUseCase implements UseCase<List<HopperEntity>, NoParams> {
  final IProductionRepository _repository;

  GetHoppersUseCase(this._repository);

  @override
  Future<Either<Failure, List<HopperEntity>>> call(NoParams params) {
    return _repository.getHoppers();
  }
}
