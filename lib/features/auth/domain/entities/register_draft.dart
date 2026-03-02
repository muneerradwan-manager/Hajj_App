import 'package:equatable/equatable.dart';

class RegisterDraft extends Equatable {
  final String email;
  final String phone;
  final String nationalityNumber;
  final String barcode;
  final String password;
  final String confirmPassword;
  final int stepNumber;

  const RegisterDraft({
    this.email = '',
    this.phone = '',
    this.nationalityNumber = '',
    this.barcode = '',
    this.password = '',
    this.confirmPassword = '',
    this.stepNumber = 1,
  });

  RegisterDraft copyWith({
    String? email,
    String? phone,
    String? nationalityNumber,
    String? barcode,
    String? password,
    String? confirmPassword,
    int? stepNumber,
  }) {
    return RegisterDraft(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalityNumber: nationalityNumber ?? this.nationalityNumber,
      barcode: barcode ?? this.barcode,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      stepNumber: stepNumber ?? this.stepNumber,
    );
  }

  @override
  List<Object?> get props => [
    email,
    phone,
    nationalityNumber,
    barcode,
    password,
    confirmPassword,
    stepNumber,
  ];
}
