import '../../../../core/models/attachment_model.dart';
import '../../domain/entities/complaint.dart';

class ComplaintModel {
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
  final List<AttachmentModel> attachments;

  const ComplaintModel({
    required this.complaintId,
    required this.categoryId,
    required this.kindId,
    required this.statusId,
    required this.categoryName,
    required this.kindName,
    required this.statusName,
    required this.statusIsClosed,
    required this.subject,
    required this.message,
    required this.userEmail,
    required this.pilgrimFullName,
    required this.createdAt,
    required this.answer,
    required this.answeredAt,
    required this.closedAt,
    required this.attachments,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    final category = _asMap(json['category']);
    final kind = _asMap(json['kind']);
    final status = _asMap(json['status']);
    final attachmentsJson = (json['attachments'] as List<dynamic>?) ?? [];

    return ComplaintModel(
      complaintId: json['complaintId'] ?? json['id'] ?? 0,
      categoryId: category?['categoryId'] ?? json['categoryId'],
      kindId: kind?['kindId'] ?? json['kindId'],
      statusId: status?['statusId'] ?? json['statusId'],
      categoryName: category?['name'] ?? json['categoryName'] ?? '',
      kindName: kind?['name'] ?? json['kindName'] ?? '',
      statusName: status?['name'] ?? json['status'] ?? '',
      statusIsClosed: status?['isClosed'] ?? json['isClosed'],
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      userEmail: json['userEmail'] ?? '',
      pilgrimFullName: json['pilgrimFullName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      answer: json['answer'],
      answeredAt: json['answeredAt'],
      closedAt: json['closedAt'],
      attachments: attachmentsJson
          .map((e) =>
              AttachmentModel.fromJson(_asMap(e) ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaintId': complaintId,
      'categoryId': categoryId,
      'kindId': kindId,
      'statusId': statusId,
      'categoryName': categoryName,
      'kindName': kindName,
      'status': statusName,
      'statusIsClosed': statusIsClosed,
      'subject': subject,
      'message': message,
      'userEmail': userEmail,
      'pilgrimFullName': pilgrimFullName,
      'createdAt': createdAt,
      'answer': answer,
      'answeredAt': answeredAt,
      'closedAt': closedAt,
      'attachments': attachments.map((e) => e.toJson()).toList(),
    };
  }

  Complaint toEntity() {
    return Complaint(
      complaintId: complaintId,
      categoryId: categoryId,
      kindId: kindId,
      statusId: statusId,
      categoryName: categoryName,
      kindName: kindName,
      statusName: statusName,
      statusIsClosed: statusIsClosed,
      subject: subject,
      message: message,
      userEmail: userEmail,
      pilgrimFullName: pilgrimFullName,
      createdAt: createdAt,
      answer: answer,
      answeredAt: answeredAt,
      closedAt: closedAt,
      attachments: attachments.map((a) => a.toEntity()).toList(),
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, v) => MapEntry(key.toString(), v));
    }
    return null;
  }
}


