import '../../../../core/entites/attachment.dart';

enum ComplaintStatusType { pending, inReview, resolved }

class Complaint {
  final int complaintId;
  final int? categoryId;
  final int? kindId;
  final int? statusId;
  final String categoryName;
  final String kindName;
  final String statusName;
  final bool? statusIsClosed;
  final String subject;
  final String message;
  final String userEmail;
  final String pilgrimFullName;
  final String? answer;
  final String createdAt;
  final String? answeredAt;
  final String? closedAt;
  final List<Attachment> attachments;

  const Complaint({
    required this.complaintId,
    required this.categoryName,
    required this.kindName,
    required this.statusName,
    required this.subject,
    required this.message,
    required this.userEmail,
    required this.pilgrimFullName,
    required this.createdAt,
    required this.attachments,
    this.categoryId,
    this.kindId,
    this.statusId,
    this.statusIsClosed,
    this.answer,
    this.answeredAt,
    this.closedAt,
  });

  bool get hasAnswer => answer != null && answer!.trim().isNotEmpty;

  ComplaintStatusType get statusType {
    if (statusIsClosed == true) return ComplaintStatusType.resolved;
    if (statusId == 2) return ComplaintStatusType.inReview;
    return ComplaintStatusType.pending;
  }

  String get createdDate => _shortDate(createdAt);
  String get answeredDate => _shortDate(answeredAt);
  String get closedDate => _shortDate(closedAt);

  String _shortDate(String? value) {
    if (value == null || value.isEmpty) return '';
    final tIndex = value.indexOf('T');
    if (tIndex == -1) return value;
    return value.substring(0, tIndex);
  }
}
