import 'package:image_picker/image_picker.dart';
import 'package:web_analise_app/core/domain/entities/picture_entity.dart';
import 'package:web_analise_app/core/services/device/device_service.dart';

final class DeviceServiceImpl implements IDeviceService {
  final ImagePicker _imagePicker;

  DeviceServiceImpl(this._imagePicker);

  @override
  Future<PictureEntity?> takePicture() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      return null;
    }

    return PictureEntity(path: image.path);
  }
}
