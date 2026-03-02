class ConfirmEmailRequestModel {
  final String email;
  final String otp;

  const ConfirmEmailRequestModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
