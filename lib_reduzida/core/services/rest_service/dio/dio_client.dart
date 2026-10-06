import 'package:dio/dio.dart';
import 'package:web_analise_app/core/services/credential/credential_service.dart';
import 'package:web_analise_app/core/services/network/interceptors/auth_interceptor.dart';
import 'package:web_analise_app/core/services/network/interceptors/error_interceptor.dart';
import 'package:web_analise_app/core/services/network/interceptors/logger_interceptor.dart';
import 'package:web_analise_app/shared/constants/app_durations.dart';

final class DioClient {
  const DioClient._();

  static Dio create(ICredentialService credentialService) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: AppDurations.connectTimeout,
        receiveTimeout: AppDurations.receiveTimeout,
        sendTimeout: AppDurations.sendTimeout,
      ),
    );

    dio.interceptors.addAll([
      //OS INTERCEPTORS NÃO PODEM SER MOSTRADOS NO PORTFÓLIO POR QUESTÕES DE SEGURANÇA
    ]);

    return dio;
  }
}
