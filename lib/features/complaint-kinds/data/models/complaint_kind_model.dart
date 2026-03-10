import '../../domain/entities/complaint_kind.dart';

class ComplaintKindModel {
  final int? kindId;
  final String name;
  final bool isActive;

  const ComplaintKindModel({
    required this.kindId,
    required this.name,
    required this.isActive,
  });

  factory ComplaintKindModel.fromJson(Map<String, dynamic> json) {
    return ComplaintKindModel(
      kindId: json['kindId'] as int?,
      name: json['name'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'kindId': kindId,
    'name': name,
    'isActive': isActive,
  };

  ComplaintKind toEntity() =>
      ComplaintKind(kindId: kindId, name: name, isActive: isActive);
}
