import 'package:hajj_app/features/auth/domain/entities/register_draft.dart';

class RegisterDraftModel {
  final String email;
  final String phone;
  final String nationalityNumber;
  final String barcode;
  final String password;
  final String confirmPassword;
  final int stepNumber;

  const RegisterDraftModel({
    required this.email,
    required this.phone,
    required this.nationalityNumber,
    required this.barcode,
    required this.password,
    required this.confirmPassword,
    required this.stepNumber,
  });

  factory RegisterDraftModel.fromEntity(RegisterDraft draft) {
    return RegisterDraftModel(
      email: draft.email,
      phone: draft.phone,
      nationalityNumber: draft.nationalityNumber,
      barcode: draft.barcode,
      password: draft.password,
      confirmPassword: draft.confirmPassword,
      stepNumber: draft.stepNumber,
    );
  }

  RegisterDraft toEntity() {
    return RegisterDraft(
      email: email,
      phone: phone,
      nationalityNumber: nationalityNumber,
      barcode: barcode,
      password: password,
      confirmPassword: confirmPassword,
      stepNumber: stepNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'nationalityNumber': nationalityNumber,
      'barcode': barcode,
      'password': password,
      'confirmPassword': confirmPassword,
      'stepNumber': stepNumber,
    };
  }

  factory RegisterDraftModel.fromJson(Map<String, dynamic> json) {
    return RegisterDraftModel(
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      nationalityNumber: (json['nationalityNumber'] ?? '').toString(),
      barcode: (json['barcode'] ?? '').toString(),
      password: (json['password'] ?? '').toString(),
      confirmPassword: (json['confirmPassword'] ?? '').toString(),
      stepNumber: (json['stepNumber'] as num?)?.toInt() ?? 1,
    );
  }
}
