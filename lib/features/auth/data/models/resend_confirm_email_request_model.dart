class ResendConfirmEmailRequestModel {
  final String email;

  const ResendConfirmEmailRequestModel({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
