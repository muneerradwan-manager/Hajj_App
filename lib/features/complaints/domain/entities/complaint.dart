class Complaint {
  final int complaintId;
  final String subject;
  final String categoryName;
  final String kindName;
  final String status;
  final String userEmail;
  final String pilgrimFullName;
  final bool hasAnswer;
  final String createdAt;

  const Complaint({
    required this.complaintId,
    required this.categoryName,
    required this.kindName,
    required this.status,
    required this.subject,
    required this.userEmail,
    required this.pilgrimFullName,
    required this.createdAt,
    required this.hasAnswer,
  });
}
