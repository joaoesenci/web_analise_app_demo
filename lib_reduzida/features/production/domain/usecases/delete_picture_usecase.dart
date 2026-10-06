import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';

final class DeletePictureParams {
  final int ticketId;
  final int pictureId;

  const DeletePictureParams({required this.ticketId, required this.pictureId});
}

final class DeletePictureUsecase implements UseCase<Unit, DeletePictureParams> {
  final IProductionRepository _repository;

  DeletePictureUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(DeletePictureParams params) async {
    return await _repository.deletePicture(params.ticketId, params.pictureId);
  }
}
