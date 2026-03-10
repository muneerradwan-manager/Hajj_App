import '../../domain/entities/complaint_status.dart';

class ComplaintStatusModel {
  final int? statusId;
  final String name;
  final bool isClosed;

  const ComplaintStatusModel({
    required this.statusId,
    required this.name,
    required this.isClosed,
  });

  factory ComplaintStatusModel.fromJson(Map<String, dynamic> json) {
    return ComplaintStatusModel(
      statusId: json['statusId'] as int?,
      name: json['name'] as String? ?? '',
      isClosed: json['isClosed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusId': statusId,
    'name': name,
    'isClosed': isClosed,
  };

  ComplaintStatus toEntity() =>
      ComplaintStatus(statusId: statusId, name: name, isClosed: isClosed);
}
