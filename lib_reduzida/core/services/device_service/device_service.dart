import 'package:web_analise_app/core/domain/entities/picture_entity.dart';

abstract interface class IDeviceService {
  Future<PictureEntity?> takePicture();
}
