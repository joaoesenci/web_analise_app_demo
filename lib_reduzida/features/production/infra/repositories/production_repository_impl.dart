import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failure_mapper.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/domain/entities/weighing_entity.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';
import 'package:web_analise_app/features/production/infra/datasources/production_datasource.dart';
import 'package:web_analise_app/features/production/infra/models/weighing_model.dart';

final class ProductionRepositoryImpl implements IProductionRepository {
  final IProductionDatasource datasource;

  ProductionRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<HopperEntity>>> getHoppers() async {
    try {
      final List<HopperEntity> hoppers = await datasource.getHoppers();

      return right(hoppers);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> emptyHopper(int id) async {
    try {
      await datasource.emptyHopper(id);

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> setUnloadingStatus(
    int id,
    String status,
  ) async {
    try {
      await datasource.setUnloadingStatus(id, status);

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveWeight(
    int id,
    WeighingEntity weighing,
  ) async {
    try {
      await datasource.saveWeight(id, WeighingModel.fromEntity(weighing));

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertPicture(
    int ticketId,
    String picturePath,
  ) async {
    try {
      await datasource.insertPicture(ticketId, picturePath);

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePicture(
    int ticketId,
    int pictureId,
  ) async {
    try {
      await datasource.deletePicture(ticketId, pictureId);

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }
}
