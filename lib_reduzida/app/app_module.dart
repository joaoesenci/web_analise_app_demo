import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_analise_app/app/app_routes.dart';
import 'package:web_analise_app/core/core_module.dart';
import 'package:web_analise_app/features/auth/auth_module.dart';
import 'package:web_analise_app/features/home/home_module.dart';
import 'package:web_analise_app/features/production/production_module.dart';
import 'package:web_analise_app/features/silos/silos_module.dart';
import 'package:web_analise_app/features/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.module(AppRoutes.production, module: ProductionModule());
  }
}
