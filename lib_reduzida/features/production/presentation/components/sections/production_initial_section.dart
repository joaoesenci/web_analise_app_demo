import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:web_analise_app/app/app_routes.dart';
import 'package:web_analise_app/features/production/presentation/components/sections/production_page_sections/initial_section_steps/hopper_step.dart';
import 'package:web_analise_app/features/production/presentation/components/sections/production_page_sections/initial_section_steps/production_input_step.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_cubit.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_state.dart';
import 'package:web_analise_app/features/production/production_routes.dart';

class ProductionInitialSection extends StatelessWidget {
  final ProductionState state;
  final ProductionCubit cubit;
  final PageController pageController;
  final ScrollController ticketsScrollController;
  final ScrollController hoppersScrollController;
  final TextEditingController grossWeightController;
  final TextEditingController tareWeightController;
  final TextEditingController impurityWeightController;
  final TextEditingController moistureController;

  const ProductionInitialSection({
    super.key,
    required this.state,
    required this.cubit,
    required this.ticketsScrollController,
    required this.hoppersScrollController,
    required this.pageController,
    required this.grossWeightController,
    required this.tareWeightController,
    required this.impurityWeightController,
    required this.moistureController,
  });

  void _disposeWeighingControllers() {
    if (grossWeightController.text.isNotEmpty ||
        tareWeightController.text.isNotEmpty ||
        impurityWeightController.text.isNotEmpty ||
        moistureController.text.isNotEmpty) {
      grossWeightController.clear();
      tareWeightController.clear();
      impurityWeightController.clear();
      moistureController.clear();
    }
  }

  void _onSaveWeighing(int id) {
    cubit.onSaveWeight(
      id,
      grossWeightController.text,
      tareWeightController.text,
      impurityWeightController.text,
      moistureController.text,
    );

    Modular.to.pop();
  }

  void _onCancelModal() {
    Modular.to.pop();
    _disposeWeighingControllers();
  }

  void _onTapShowDetails(int id) async {
    final ticket = await cubit.getTicket(id);

    if (ticket == null) return;

    Modular.to.pushNamed(
      '${AppRoutes.production}${ProductionRoutes.addTicket}',
      arguments: {
        'hoppers': cubit.state.hoppers,
        'initialStep': 4,
        'ticket': ticket,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ProductionInputStep(
          tickets: state.productionTickets,
          ticketsScrollController: ticketsScrollController,
          grossWeightController: grossWeightController,
          tareWeightController: tareWeightController,
          impurityWeightController: impurityWeightController,
          moistureController: moistureController,
          onSaveWeighing: _onSaveWeighing,
          onCancelModal: _onCancelModal,
          whenCompleteModal: _disposeWeighingControllers,
          onTapShowDetails: _onTapShowDetails,
          onTapStartUnloading: cubit.showStartUnloadingModal,
          onTapFinishUnloading: cubit.showFinishUnloadingModal,
        ),
        HopperStep(
          hoppers: state.hoppers,
          scrollController: hoppersScrollController,
          onCancelModal: _onCancelModal,
          onTapEmptyHopper: cubit.showEmptyHopperModal,
          onTapCleaningHopper: cubit.showCleaningHopperModal,
        ),
      ],
    );
  }
}
