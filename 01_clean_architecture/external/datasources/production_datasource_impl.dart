import 'package:dio/dio.dart';
import 'package:web_analise_app/core/domain/errors/exceptions.dart';
import 'package:web_analise_app/core/services/network/api/api_service.dart';
import 'package:web_analise_app/core/services/network/api/endpoints.dart';
import 'package:web_analise_app/core/services/network/dio/dio_exception_extension.dart';
import 'package:web_analise_app/features/production/infra/datasources/production_datasource.dart';
import 'package:web_analise_app/features/production/infra/models/hopper_model.dart';
import 'package:web_analise_app/features/production/infra/models/weighing_model.dart';

final class ProductionDatasourceImpl implements IProductionDatasource {
  final IApiService api;

  ProductionDatasourceImpl(this.api);

  @override
  Future<List<HopperModel>> getHoppers() async {
    try {
      final response = await api.get('***endpoint ocultado para portfólio***');

      final models = (response.data['data'] as List)
          .map((i) => HopperModel.fromMap(i as Map<String, dynamic>))
          .toList();

      return models;
    } on DioException catch (e) {
      throw e.toAppException();
    } on FormatException {
      throw ParseException();
    }
  }

  @override
  Future<void> emptyHopper(int id) async {
    try {
      await api.path('***endpoint ocultado para portfólio***');
    } on DioException catch (e) {
      throw e.toAppException();
    } on FormatException {
      throw ParseException();
    }
  }

  @override
  Future<void> setUnloadingStatus(int id, String status) async {
    try {
      final Map<String, dynamic> data = {
        'nome-do-campo': {'nome-do-campo': id, 'nome-do-campo': status},
      };

      await api.path('***endpoint ocultado para portfólio***', data: data);
    } on DioException catch (e) {
      throw e.toAppException();
    } on FormatException {
      throw ParseException();
    }
  }

  @override
  Future<void> saveWeight(int id, WeighingModel weighing) async {
    try {
      final Map<String, dynamic> data = {
        'nome-do-campo': {
          'nome-do-campo': weighing.grossWeight,
          'nome-do-campo': weighing.tareWeight,
          'nome-do-campo': weighing.impurityWeight,
          'nome-do-campo': weighing.moisture,
        },
      };

      await api.path('***endpoint ocultado para portfólio***', data: data);
    } on DioException catch (e) {
      throw e.toAppException();
    } on FormatException {
      throw ParseException();
    }
  }
}

// Está como 'nome do campo' para proteger o arquivo json real no portfólio, mantendo a segurança.
