import 'package:equatable/equatable.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/domain/entities/production_ticket_entity.dart';
import 'package:web_analise_app/features/production/presentation/cubits/production/production_enum.dart';

final class ProductionState extends Equatable {
  final ProductionStatus status;
  final ProductionFeedbackStatus? feedbackStatus;
  final String? errorMessage;
  final int currentStep;
  final int? selectedTicketId;
  final int? selectedHopperId;
  final List<ProductionTicketEntity> productionTickets;
  final List<HopperEntity> hoppers;

  const ProductionState({
    this.status = ProductionStatus.initial,
    this.feedbackStatus,
    this.errorMessage,
    this.currentStep = 0,
    this.selectedTicketId,
    this.selectedHopperId,
    this.productionTickets = const [],
    this.hoppers = const [],
  });

  ProductionState copyWith({
    ProductionStatus? status,
    ProductionFeedbackStatus? feedbackStatus,
    String? errorMessage,
    int? currentStep,
    int? selectedTicketId,
    int? selectedHopperId,
    List<ProductionTicketEntity>? productionTickets,
    List<HopperEntity>? hoppers,
  }) {
    return ProductionState(
      status: status ?? this.status,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      selectedTicketId: selectedTicketId ?? this.selectedTicketId,
      selectedHopperId: selectedHopperId ?? this.selectedHopperId,
      productionTickets: productionTickets ?? this.productionTickets,
      hoppers: hoppers ?? this.hoppers,
    );
  }

  @override
  List<Object?> get props => [
    status,
    feedbackStatus,
    currentStep,
    productionTickets,
    hoppers,
  ];
}
