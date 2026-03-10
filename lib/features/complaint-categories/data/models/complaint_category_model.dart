import '../../domain/entities/complaint_category.dart';

class ComplaintCategoryModel {
  final int? categoryId;
  final String name;
  final bool isActive;

  const ComplaintCategoryModel({
    required this.categoryId,
    required this.name,
    required this.isActive,
  });

  factory ComplaintCategoryModel.fromJson(Map<String, dynamic> json) {
    return ComplaintCategoryModel(
      categoryId: json['categoryId'] as int?,
      name: json['name'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'name': name,
    'isActive': isActive,
  };

  ComplaintCategory toEntity() =>
      ComplaintCategory(categoryId: categoryId, name: name, isActive: isActive);
}
