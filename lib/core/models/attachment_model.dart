import '../entites/attachment.dart';

class ComplaintAttachmentModel {
  final int id;
  final String attachName;
  final String attachPath;
  final String uploadedAt;

  const ComplaintAttachmentModel({
    required this.id,
    required this.attachName,
    required this.attachPath,
    required this.uploadedAt,
  });

  factory ComplaintAttachmentModel.fromJson(Map<String, dynamic> json) {
    return ComplaintAttachmentModel(
      id: json['id'] ?? 0,
      attachName: json['attachName'] ?? '',
      attachPath: json['attachPath'] ?? '',
      uploadedAt: json['uploadedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'attachName': attachName,
        'attachPath': attachPath,
        'uploadedAt': uploadedAt,
      };

  ComplaintAttachment toEntity() => ComplaintAttachment(
        id: id,
        attachName: attachName,
        attachPath: attachPath,
        uploadedAt: uploadedAt,
      );
}
