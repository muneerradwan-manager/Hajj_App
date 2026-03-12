class SubmitPhaseResult {
  final int phaseId;
  final int submittedCount;
  final int skippedAlreadyAnsweredCount;

  const SubmitPhaseResult({
    required this.phaseId,
    required this.submittedCount,
    required this.skippedAlreadyAnsweredCount,
  });
}
