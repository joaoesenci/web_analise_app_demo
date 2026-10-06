import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:web_analise_app/app/app_routes.dart';
import 'package:web_analise_app/features/production/presentation/components/sections/production_page_sections/production_initial_section.dart';
import 'package:web_analise_app/features/production/presentation/components/sections/production_page_sections/production_loading_section.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_appbar.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_cubit.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_enum.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_state.dart';
import 'package:web_analise_app/features/production/production_routes.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:web_analise_app/shared/widgets/snackbars/error_snack_bar.dart';

class ProductionPage extends StatefulWidget {
  final ProductionCubit cubit;

  const ProductionPage({super.key, required this.cubit});

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  ProductionCubit get _cubit => widget.cubit;

  late PageController pageController;
  late ScrollController ticketsScrollController;
  late ScrollController hoppersScrollController;
  late TextEditingController grossWeightTextController;
  late TextEditingController tareWeightTextController;
  late TextEditingController impurityWeightTextController;
  late TextEditingController moistureTextController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _cubit.state.currentStep);
    ticketsScrollController = ScrollController();
    hoppersScrollController = ScrollController();
    grossWeightTextController = TextEditingController();
    tareWeightTextController = TextEditingController();
    impurityWeightTextController = TextEditingController();
    moistureTextController = TextEditingController();
    _cubit.loadProductionData();
  }

  @override
  void dispose() {
    pageController.dispose();
    ticketsScrollController.dispose();
    hoppersScrollController.dispose();
    grossWeightTextController.dispose();
    tareWeightTextController.dispose();
    impurityWeightTextController.dispose();
    moistureTextController.dispose();
    super.dispose();
  }

  void _popClearDialog() {
    _cubit.clearFeedbackStatus();
    Modular.to.pop();
  }

  void _popUntilInit() async {
    Modular.to.popUntil(
      ModalRoute.withName('${AppRoutes.production}${ProductionRoutes.init}'),
    );
  }

  void _onStartCleaningHopper() {
    Modular.to.pop();

    final hopper = _cubit.state.hoppers.firstWhereOrNull(
      (i) => _cubit.state.selectedHopperId == i.id,
    );

    if (hopper == null) {
      ErrorSnackBar.show(
        context: context,
        title: 'Erro',
        message: 'Moega não encontrada',
      );
      return;
    }

    _cubit.clearFeedbackStatus();
    Modular.to.pushNamed(
      '${AppRoutes.production}${ProductionRoutes.cleaningHopper}',
      arguments: hopper,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductionCubit, ProductionState>(
      bloc: _cubit,

      listenWhen: (previous, current) =>
          previous.feedbackStatus != current.feedbackStatus ||
          previous.currentStep != current.currentStep,

      listener: (context, state) {
        if (pageController.hasClients &&
            pageController.page?.round() != state.currentStep) {
          pageController.jumpToPage(state.currentStep);
        }

        switch (state.feedbackStatus) {
          case ProductionFeedbackStatus.error:
            final message = state.errorMessage;
            if (message != null) {
              ErrorSnackBar.show(
                context: context,
                title: 'Erro',
                message: message,
              );
            }
            _cubit.clearFeedbackStatus();
            break;

          case ProductionFeedbackStatus.startUnloading:
            AppConfirmationDialog.show(
              context: context,
              title: 'Atenção!',
              text: 'Confirmar o início do descarregamento do caminhão ?',
              onCancel: _popClearDialog,
              onConfirm: () async {
                _popUntilInit();
                await _cubit.onSetUnloadingStatus(
                  state.selectedTicketId!,
                  'in_progress',
                );
                _cubit.clearFeedbackStatus();
                await _cubit.loadProductionData();
              },
            );
            break;

          case ProductionFeedbackStatus.finishUnloading:
            AppConfirmationDialog.show(
              context: context,
              title: 'Atenção!',
              text: 'Confirmar o encerramento do descarregamento do caminhão ?',
              onCancel: _popClearDialog,
              onConfirm: () async {
                _popUntilInit();
                await _cubit.onSetUnloadingStatus(
                  state.selectedTicketId!,
                  'completed',
                );
                _cubit.clearFeedbackStatus();
                await _cubit.loadProductionData();
              },
            );
            break;

          case ProductionFeedbackStatus.emptyHopper:
            AppConfirmationDialog.show(
              context: context,
              title: 'Atenção!',
              text: 'Confirmar o esvaziamento da moega ?',
              onCancel: _popClearDialog,
              onConfirm: () async {
                _popUntilInit();
                await _cubit.onEmptyHopper(state.selectedHopperId!);
                await _cubit.loadHopperData();
              },
            );
            break;

          case ProductionFeedbackStatus.cleaningHopper:
            _onStartCleaningHopper();
            break;

          default:
            break;
        }
      },

      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.currentStep != current.currentStep,

      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.surface,

          appBar: ProductionAppbar(
            currentStepIndex: state.currentStep,
            onChangePage: (stepIndex) => _cubit.changeStep(stepIndex),
          ),

          floatingActionButton:
              state.status == ProductionStatus.initial && state.currentStep == 0
              ? SizedBox(
                  height: 72,
                  width: 72,
                  child: FloatingActionButton(
                    onPressed: () => Modular.to.pushNamed(
                      '${AppRoutes.production}${ProductionRoutes.addTicket}',
                      arguments: {'hoppers': state.hoppers, 'initialStep': 0},
                    ),
                    child: Icon(Icons.add, size: AppIconSizes.large),
                  ),
                )
              : null,

          body: switch (state.status) {
            ProductionStatus.initial => ProductionInitialSection(
              state: state,
              cubit: _cubit,
              pageController: pageController,
              ticketsScrollController: ticketsScrollController,
              hoppersScrollController: hoppersScrollController,
              grossWeightController: grossWeightTextController,
              tareWeightController: tareWeightTextController,
              impurityWeightController: impurityWeightTextController,
              moistureController: moistureTextController,
            ),

            ProductionStatus.loading => ProductionLoadingSection(),
          },
        );
      },
    );
  }
}
