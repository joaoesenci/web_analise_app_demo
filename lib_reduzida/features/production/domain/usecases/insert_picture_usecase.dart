import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class InsertPictureParams {
  final int ticketId;
  final String picturePath;

  const InsertPictureParams({
    required this.ticketId,
    required this.picturePath,
  });
}

final class InsertPictureUsecase implements UseCase<Unit, InsertPictureParams> {
  final IProductionRepository _repository;

  InsertPictureUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(InsertPictureParams params) async {
    return await _repository.insertPicture(params.ticketId, params.picturePath);
  }
}
