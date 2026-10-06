import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:web_analise_app/core/services/network/api/api_service.dart';
import 'package:web_analise_app/core/services/network/api/api_service_impl.dart';

final class CoreModule extends Module {
  @override
  void binds(Injector i) {
    // ---------- INSTANCES ----------
    i.addLazySingleton<Dio>(
      () => DioClient.create(Modular.get<ICredentialService>()),
    );
    i.addLazySingleton<ImagePicker>(() => ImagePicker());

    // ---------- SERVICES ----------
    i.addLazySingleton<ISessionManager>(() => Modular.get<SessionCubit>());
    i.addLazySingleton<IApiService>(() => ApiServiceImpl(Modular.get<Dio>()));
    i.addLazySingleton<IDeviceService>(
      () => DeviceServiceImpl(Modular.get<ImagePicker>()),
    );
  }
}
