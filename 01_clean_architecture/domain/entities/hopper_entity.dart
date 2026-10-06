class HopperEntity {
  final int id;
  final String hopperName;
  final String status;
  final int totalWeight;
  final int totalLoads;
  final String? category;
  final String? growerName;
  final String? memberName;
  final String? varietyName;

  const HopperEntity({
    required this.id,
    required this.hopperName,
    required this.status,
    required this.totalWeight,
    required this.totalLoads,
    this.category,
    this.growerName,
    this.memberName,
    this.varietyName,
  });
}
