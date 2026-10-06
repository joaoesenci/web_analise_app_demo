import 'package:fpdart/fpdart.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/domain/entities/weighing_entity.dart';

abstract interface class IProductionRepository {
  Future<Either<Failure, List<HopperEntity>>> getHoppers();
  Future<Either<Failure, Unit>> emptyHopper(int id);
  Future<Either<Failure, Unit>> setUnloadingStatus(int id, String status);
  Future<Either<Failure, Unit>> saveWeight(int id, WeighingEntity weighing);
  Future<Either<Failure, Unit>> insertPicture(int ticketId, String picturePath);
  Future<Either<Failure, Unit>> deletePicture(int ticketId, int pictureId);
}
