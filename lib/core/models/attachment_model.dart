import '../entites/attachment.dart';

class AttachmentModel {
  final int id;
  final String attachName;
  final String attachPath;
  final String uploadedAt;

  const AttachmentModel({
    required this.id,
    required this.attachName,
    required this.attachPath,
    required this.uploadedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] ?? 0,
      attachName: json['attachName'] ?? '',
      attachPath: json['attachPath'] ?? '',
      uploadedAt: json['uploadedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attachName': attachName,
      'attachPath': attachPath,
      'uploadedAt': uploadedAt,
    };
  }

  Attachment toEntity() {
    return Attachment(
      id: id,
      attachName: attachName,
      attachPath: attachPath,
      uploadedAt: uploadedAt,
    );
  }
}