class Phase {
  final int phaseId;
  final String phaseName;
  final String phaseDescription;
  final bool isActive;
  final bool isDeleted;

  const Phase({
    required this.phaseId,
    required this.phaseName,
    required this.phaseDescription,
    required this.isActive,
    required this.isDeleted,
  });
}
