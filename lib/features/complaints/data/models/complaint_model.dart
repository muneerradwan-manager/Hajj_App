import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';

class ComplaintModel {
  final int complaintId;
  final String subject;
  final String categoryName;
  final String kindName;
  final String status;
  final String userEmail;
  final String? pilgrimFullName;
  final bool hasAnswer;
  final String createdAt;

  const ComplaintModel({
    required this.complaintId,
    required this.categoryName,
    required this.kindName,
    required this.status,
    required this.subject,
    required this.userEmail,
     this.pilgrimFullName,
    required this.createdAt,
    required this.hasAnswer,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintId: json['complaintId'],
      categoryName: json['categoryName'],
      kindName: json['kindName'],
      status: json['status'],
      subject: json['subject'],
      userEmail: json['userEmail'],
      pilgrimFullName: json['pilgrimFullName'],
      createdAt: json['createdAt'],
      hasAnswer: json['hasAnswer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaintId': complaintId,
      'categoryName': categoryName,
      'kindName': kindName,
      'status': status,
      'subject': subject,
      'userEmail': userEmail,
      'pilgrimFullName': pilgrimFullName,
      'hasAnswer': hasAnswer,
      'createdAt': createdAt,
    };
  }

  Complaint toEntity() {
    return Complaint(
      complaintId: complaintId,
      categoryName: categoryName,
      kindName: kindName,
      status: status,
      subject: subject,
      userEmail: userEmail,
      pilgrimFullName: pilgrimFullName ?? '',
      createdAt: createdAt,
      hasAnswer: hasAnswer,
    );
  }
}
