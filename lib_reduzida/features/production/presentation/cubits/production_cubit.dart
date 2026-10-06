import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_analise_app/core/domain/errors/failures.dart';
import 'package:web_analise_app/core/domain/usecases/usecase.dart';
import 'package:web_analise_app/core/services/session/session_manager.dart';
import 'package:web_analise_app/features/production/domain/entities/weighing_entity.dart';
import 'package:web_analise_app/features/production/domain/usecases/empty_hopper_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/get_hoppers_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/get_production_tickets_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/get_ticket_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/save_weight_usecase.dart';
import 'package:web_analise_app/features/production/domain/usecases/set_unloading_status_usecase.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_enum.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_state.dart';

class ProductionCubit extends Cubit<ProductionState> {
  final ISessionManager _sessionManager;
  final GetHoppersUseCase _getHoppersUseCase;
  final SetUnloadingStatusUseCase _setUnloadingStatusUseCase;
  final SaveWeightUseCase _saveWeightUseCase;
  final EmptyHopperUseCase _emptyHopperUseCase;

  ProductionCubit({
    required ISessionManager sessionManager,
    required GetProductionTicketsUseCase getProductionTicketsUseCase,
    required GetHoppersUseCase getHoppersUseCase,
    required SetUnloadingStatusUseCase setUnloadingStatusUseCase,
    required SaveWeightUseCase saveWeightUseCase,
    required GetTicketUseCase getTicket,
    required EmptyHopperUseCase emptyHopperUseCase,
  }) : _sessionManager = sessionManager,
       _getHoppersUseCase = getHoppersUseCase,
       _setUnloadingStatusUseCase = setUnloadingStatusUseCase,
       _saveWeightUseCase = saveWeightUseCase,
       _emptyHopperUseCase = emptyHopperUseCase,
       super(const ProductionState());

  //----------------------------------------------------------------------
  // UI FUNCTIONS
  //----------------------------------------------------------------------
  void clearFeedbackStatus() {
    emit(
      state.copyWith(
        feedbackStatus: ProductionFeedbackStatus.none,
        errorMessage: null,
      ),
    );
  }

  void changeStep(int stepIndex) {
    emit(state.copyWith(currentStep: stepIndex));
  }

  void showStartUnloadingModal(int id) {
    emit(
      state.copyWith(
        feedbackStatus: ProductionFeedbackStatus.startUnloading,
        selectedTicketId: id,
      ),
    );
  }

  void showFinishUnloadingModal(int id) {
    emit(
      state.copyWith(
        feedbackStatus: ProductionFeedbackStatus.finishUnloading,
        selectedTicketId: id,
      ),
    );
  }

  void showEmptyHopperModal(int id) {
    emit(
      state.copyWith(
        selectedHopperId: id,
        feedbackStatus: ProductionFeedbackStatus.emptyHopper,
      ),
    );
  }

  void showCleaningHopperModal(int id) {
    emit(
      state.copyWith(
        selectedHopperId: id,
        feedbackStatus: ProductionFeedbackStatus.cleaningHopper,
      ),
    );
  }

  //----------------------------------------------------------------------
  // BUSINESS LOGIC FUNCTIONS
  //----------------------------------------------------------------------
  Future<void> loadProductionData() async {
    emit(state.copyWith(status: ProductionStatus.loading));

    await _loadHoppers();

    if (state.feedbackStatus != ProductionFeedbackStatus.error) {
      emit(state.copyWith(status: ProductionStatus.initial));
    }
  }

  Future<void> loadHopperData() async {
    clearFeedbackStatus();
    emit(state.copyWith(status: ProductionStatus.loading));

    await _loadHoppers();

    if (state.feedbackStatus != ProductionFeedbackStatus.error) {
      emit(state.copyWith(status: ProductionStatus.initial, currentStep: 1));
    }
  }

  Future<void> onEmptyHopper(int id) async {
    final result = await _emptyHopperUseCase(EmptyHopperParams(id: id));

    result.fold((failure) {
      if (failure is UnauthorizedFailure && failure.requiresLogout) {
        _sessionManager.logout();
        return;
      }
      emit(
        state.copyWith(
          feedbackStatus: ProductionFeedbackStatus.error,
          errorMessage: failure.message,
        ),
      );
    }, (_) {});
  }

  Future<void> onSetUnloadingStatus(int id, String status) async {
    final result = await _setUnloadingStatusUseCase(
      SetUnloadingStatusParams(id, status),
    );

    result.fold(
      (failure) {
        if (failure is UnauthorizedFailure && failure.requiresLogout) {
          _sessionManager.logout();
          return;
        }
        emit(
          state.copyWith(
            feedbackStatus: ProductionFeedbackStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) => emit(
        state.copyWith(
          feedbackStatus: status == 'in_progress'
              ? ProductionFeedbackStatus.startUnloading
              : ProductionFeedbackStatus.finishUnloading,
        ),
      ),
    );
  }

  Future<void> onSaveWeight(
    int id,
    String gross,
    String tare,
    String impurity,
    String moisture,
  ) async {
    final weighing = WeighingEntity(
      grossWeight: _intFromString(gross),
      tareWeight: _intFromString(tare),
      impurityWeight: _intFromString(impurity),
      moisture: double.parse(moisture.replaceAll(',', '.')),
    );

    final result = await _saveWeightUseCase(
      SaveWeightParams(id: id, weighing: weighing),
    );

    result.fold((failure) {
      if (failure is UnauthorizedFailure && failure.requiresLogout) {
        _sessionManager.logout();
        return;
      }
      emit(
        state.copyWith(
          feedbackStatus: ProductionFeedbackStatus.error,
          errorMessage: failure.message,
        ),
      );
    }, (_) {});
  }

  //----------------------------------------------------------------------
  // PRIVATE FUNCTIONS
  //----------------------------------------------------------------------
  Future<void> _loadHoppers() async {
    final result = await _getHoppersUseCase(noParams);

    result.fold((failure) {
      if (failure is UnauthorizedFailure && failure.requiresLogout) {
        _sessionManager.logout();
        return;
      }
      emit(
        state.copyWith(
          feedbackStatus: ProductionFeedbackStatus.error,
          errorMessage: failure.message,
        ),
      );
    }, (hoppers) => emit(state.copyWith(hoppers: hoppers)));
  }

  int _intFromString(String text) {
    final newValue = int.parse(text.replaceAll('.', ''));

    return newValue;
  }
}
