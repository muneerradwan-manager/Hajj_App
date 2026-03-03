import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';

class RegisterRequestModel {
  final String email;
  final String phone;
  final String nationalityNumber;
  final int barcode;
  final String password;
  final String confirmPassword;

  const RegisterRequestModel({
    required this.email,
    required this.phone,
    required this.nationalityNumber,
    required this.barcode,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterRequestModel.fromDraft(RegisterDraft draft) {
    final parsedBarcode = int.tryParse(draft.barcode.trim()) ?? 0;

    return RegisterRequestModel(
      email: draft.email.trim(),
      phone: draft.phone.trim(),
      nationalityNumber: draft.nationalityNumber.trim(),
      barcode: parsedBarcode,
      password: draft.password.trim(),
      confirmPassword: draft.confirmPassword.trim(),
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
    };
  }
}
