import '../../domain/entities/phase.dart';

class PhaseModel {
  final int phaseId;
  final String phaseName;
  final String phaseDescription;
  final bool isActive;
  final bool isDeleted;

  const PhaseModel({
    required this.phaseId,
    required this.phaseName,
    required this.phaseDescription,
    required this.isActive,
    required this.isDeleted,
  });

  factory PhaseModel.fromJson(Map<String, dynamic> json) {
    return PhaseModel(
      phaseId: json['phaseId'] ?? 0,
      phaseName: json['phaseName'] ?? '',
      phaseDescription: json['phaseDescription'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phaseId': phaseId,
      'phaseName': phaseName,
      'phaseDescription': phaseDescription,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  Phase toEntity() {
    return Phase(
      phaseId: phaseId,
      phaseName: phaseName,
      phaseDescription: phaseDescription,
      isActive: isActive,
      isDeleted: isDeleted,
    );
  }
}
