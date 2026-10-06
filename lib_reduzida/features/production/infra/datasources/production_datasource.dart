import 'package:web_analise_app/features/production/infra/models/hopper_model.dart';
import 'package:web_analise_app/features/production/infra/models/weighing_model.dart';

abstract interface class IProductionDatasource {
  Future<List<HopperModel>> getHoppers();
  Future<void> emptyHopper(int id);
  Future<void> setUnloadingStatus(int id, String status);
  Future<void> saveWeight(int id, WeighingModel weighing);
  Future<void> insertPicture(int ticketId, String picturePath);
  Future<void> deletePicture(int ticketId, int pictureId);
}
