import '../../domain/entities/submit_phase_result.dart';

class SubmitPhaseResultModel {
  final int phaseId;
  final int submittedCount;
  final int skippedAlreadyAnsweredCount;

  const SubmitPhaseResultModel({
    required this.phaseId,
    required this.submittedCount,
    required this.skippedAlreadyAnsweredCount,
  });

  factory SubmitPhaseResultModel.fromJson(Map<String, dynamic> json) {
    return SubmitPhaseResultModel(
      phaseId: json['phaseId'] ?? 0,
      submittedCount: json['submittedCount'] ?? 0,
      skippedAlreadyAnsweredCount: json['skippedAlreadyAnsweredCount'] ?? 0,
    );
  }

  SubmitPhaseResult toEntity() {
    return SubmitPhaseResult(
      phaseId: phaseId,
      submittedCount: submittedCount,
      skippedAlreadyAnsweredCount: skippedAlreadyAnsweredCount,
    );
  }
}
