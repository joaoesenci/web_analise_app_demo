import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';

final class HopperModel extends HopperEntity {
  HopperModel({
    required super.id,
    required super.hopperName,
    required super.status,
    required super.totalWeight,
    required super.totalLoads,
    super.category,
    super.growerName,
    super.memberName,
    super.varietyName,
  });

  factory HopperModel.fromMap(Map<String, dynamic> map) {
    return HopperModel(
      id: map['nome-do-campo'],
      hopperName: map['nome-do-campo'],
      status: map['nome-do-campo'],
      totalWeight: map['nome-do-campo'],
      totalLoads: map['nome-do-campo'],
      category: map['nome-do-campo'],
      growerName: map['nome-do-campo'],
      memberName: map['nome-do-campo'],
      varietyName: map['nome-do-campo'],
    );
  }
}

// Está como 'nome do campo' para proteger o arquivo json real no portfólio, mantendo a segurança.
