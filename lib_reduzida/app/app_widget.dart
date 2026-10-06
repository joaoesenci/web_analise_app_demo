import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:web_analise_app/app/app_routes.dart';
import 'package:web_analise_app/core/services/session/session_cubit.dart';
import 'package:web_analise_app/core/services/session/session_state.dart';
import 'package:web_analise_app/features/auth/auth_routes.dart';
import 'package:web_analise_app/shared/themes/app_theme.dart';
import 'package:web_analise_app/shared/widgets/dialogs/app_session_expired_dialog.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,

      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,

      builder: (context, child) {
        return BlocListener<SessionCubit, SessionState>(
          bloc: Modular.get<SessionCubit>(),

          listener: (context, state) async {
            if (state is SessionUnauthenticated) {
              final BuildContext? globalContext =
                  Modular.routerDelegate.navigatorKey.currentContext;

              if (globalContext != null) {
                await AppSessionExpiredDialog.show(
                  context: globalContext,
                  onClose: () => Modular.to.pop(),
                );
              }

              Modular.to.navigate('ROTA OCULTADA PARA PORTFÓLIO');
            }
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
