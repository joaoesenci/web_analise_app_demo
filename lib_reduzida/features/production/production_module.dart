import 'package:flutter_modular/flutter_modular.dart';
import 'package:web_analise_app/core/services/network/api/api_service.dart';
import 'package:web_analise_app/features/production/domain/repositories/production_repository.dart';
import 'package:web_analise_app/features/production/domain/usecases/empty_hopper_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/get_hoppers_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/save_weight_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/set_unloading_status_usecase.dart';
import 'package:web_analise_app/features/production/external/datasources/production_datasource_impl.dart';
import 'package:web_analise_app/features/production/infra/datasources/production_datasource.dart';
import 'package:web_analise_app/features/production/infra/repositories/production_repository_impl.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_cubit.dart';
import 'package:web_analise_app/features/production/presentation/pages/production_page.dart';
import 'package:web_analise_app/features/production/production_routes.dart';

class ProductionModule extends Module {
  @override
  void binds(Injector i) {
    // ---------- DATASOURCES ----------
    i.addLazySingleton<IProductionDatasource>(
      () => ProductionDatasourceImpl(Modular.get<IApiService>()),
    );

    // ---------- REPOSITORIES ----------
    i.addLazySingleton<IProductionRepository>(
      () => ProductionRepositoryImpl(Modular.get<IProductionDatasource>()),
    );

    // ---------- USECASES ----------
    i.add<GetHoppersUseCase>(
      () => GetHoppersUseCase(Modular.get<IProductionRepository>()),
    );
    i.add<SetUnloadingStatusUseCase>(
      () => SetUnloadingStatusUseCase(Modular.get<IProductionRepository>()),
    );
    i.add<SaveWeightUseCase>(
      () => SaveWeightUseCase(Modular.get<IProductionRepository>()),
    );
    i.add<EmptyHopperUseCase>(
      () => EmptyHopperUseCase(Modular.get<IProductionRepository>()),
    );
    i.add<InsertPictureUsecase>(
      () => InsertPictureUsecase(Modular.get<IProductionRepository>()),
    );
    i.add<DeletePictureUsecase>(
      () => DeletePictureUsecase(Modular.get<IProductionRepository>()),
    );

    // ---------- CUBITS ----------
    i.addLazySingleton<ProductionCubit>(
      () => ProductionCubit(
        sessionManager: Modular.get<ISessionManager>(),
        getHoppersUseCase: Modular.get<GetHoppersUseCase>(),
        setUnloadingStatusUseCase: Modular.get<SetUnloadingStatusUseCase>(),
        saveWeightUseCase: Modular.get<SaveWeightUseCase>(),
        emptyHopperUseCase: Modular.get<EmptyHopperUseCase>(),
      ),
    );
    i.addLazySingleton<AddTicketCubit>(
      () => AddTicketCubit(
        sessionManager: Modular.get<ISessionManager>(),
        insertPictureUsecase: Modular.get<InsertPictureUsecase>(),
        deletePictureUsecase: Modular.get<DeletePictureUsecase>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      ProductionRoutes.init,
      child: (_) => ProductionPage(cubit: Modular.get<ProductionCubit>()),
    );
    r.child(
      ProductionRoutes.addTicket,
      child: (_) {
        final args = Modular.args.data as Map<String, dynamic>;

        return AddTicketPage(
          cubit: Modular.get<AddTicketCubit>(),
          hoppers: args['hoppers'] as List<HopperEntity>,
          initialStep: args['initialStep'] as int,
          showDetailsTicket: args['ticket'] as ProductionTicketEntity?,
        );
      },
    );
  }
}
